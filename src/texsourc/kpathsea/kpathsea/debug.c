/* debug.c: help the user discover what's going on.

   Copyright 1993, 1994, 2008 Karl Berry.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this library; if not, see <http://www.gnu.org/licenses/>.  */

#include <kpathsea/config.h>

#ifdef KPSE_DEBUG /* whole file */

/* If the real definitions of fopen or fclose are macros, we lose -- the
   #undef won't restore them. */

FILE *
fopen (const char *filename,  const char *mode)
{
#if defined (KPSE_COMPAT_API)
  kpathsea kpse = kpse_def;
#endif
#undef fopen
  FILE *ret = fopen (filename, mode);
#if defined (KPSE_COMPAT_API)
  if (KPATHSEA_DEBUG_P (KPSE_DEBUG_FOPEN))
    DEBUGF3 ("fopen(%s, %s) => 0x%lx\n", filename, mode, (unsigned long) ret);
#endif
  return ret;
}

int
fclose (FILE * f)
{
#if defined (KPSE_COMPAT_API)
  kpathsea kpse = kpse_def;
#endif
#undef fclose
  int ret = fclose (f);
#if defined (KPSE_COMPAT_API)
  if (KPATHSEA_DEBUG_P (KPSE_DEBUG_FOPEN))
    DEBUGF2 ("fclose(0x%lx) => %d\n", (unsigned long) f, ret);
#endif
  return ret;
}

#endif /* KPSE DEBUG */
