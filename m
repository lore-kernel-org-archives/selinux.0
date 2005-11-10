Subject: Re: [ SEMANAGE ] Fix hidden declarations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43728384.3020508@cornell.edu>
References: <43728384.3020508@cornell.edu>
Content-Type: multipart/mixed; boundary="=-KyksD48aoKDI2svnMZer"
Date: Thu, 10 Nov 2005 08:22:56 -0500
Message-Id: <1131628976.19626.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KyksD48aoKDI2svnMZer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-11-09 at 18:17 -0500, Ivan Gyurdiev wrote:
> The hidden declarations are still a mystery to me. They are present in 
> half the functions, and missing in the other half. I'm sure there's a 
> reason for this, but since I don't quite understand the pattern, I'll 
> leave them alone. There's no hidden declarations for _local.c, and 
> _policy.c, and they are missing for some of the functions in _record.c.

Explanation:  Whenever you use an exported symbol from within the DSO,
by default, interposition on the symbol is possible even for the
references within the DSO, i.e. you can override the internal definition
via another DSO.  Therefore, a relocation is required for the local
symbol reference.  This has a cost and is rarely what you want.  Thus,
by introducing hidden_proto()/hidden_def(), you create an internal
definition for all internal references that is not interposable and does
not require relocations.  This only affects exported symbols you are
calling from within the DSO itself.

> This patch:
> 
> - removes the hidden proto for sepol_user_exists(), and 
> sepol_seuser_iterate(), which make those functions invisible (no 
> hidden_def, not sure if one should be added).

No, this re-introduces relocations on those symbols (actually semanage_,
not sepol_).  Correct fix is to add hidden_defs for these symbols, not
to remove the hidden_protos.  If you had run relinfo.pl (attached) on
the .so file after applying your patch, you would have seen that it
yielded relocations on local syms.  Or you could just run readelf -r on
the .so file and grep for semanage_ prefix.

> - changes two cases of hidden_proto in iface_record.c to hidden_def, 
> because that just looks wrong.

Yes, that was a bug.

-- 
Stephen Smalley
National Security Agency

--=-KyksD48aoKDI2svnMZer
Content-Disposition: attachment; filename=relinfo.pl
Content-Type: application/x-perl; name=relinfo.pl
Content-Transfer-Encoding: 7bit

#! /usr/bin/perl
eval "exec /usr/bin/perl -S $0 $*"
    if 0;
# Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.
# Written by Ulrich Drepper <drepper@redhat.com>, 2000.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

for ($cnt = 0; $cnt <= $#ARGV; ++$cnt) {
  $relent = 0;
  $relsz = 0;
  $relcount = 0;
  $pltrelsz = 0;
  $extplt = 0;
  $users = 0;

  open (READLINK, "readlink -f $ARGV[$cnt] |") || die "cannot open readlink";
  while (<READLINK>) {
        chop;
        $fullpath = $_;
  }
  close (READLINK);

  open (READELF, "eu-readelf -d $ARGV[$cnt] |") || die "cannot open $ARGV[$cnt]";
  while (<READELF>) {
    chop;
    if (/.* RELA?ENT *([0-9]*).*/) {
      $relent = $1 + 0;
    } elsif (/.* RELA?SZ *([0-9]*).*/) {
      $relsz = $1 + 0;
    } elsif (/.* RELA?COUNT *([0-9]*).*/) {
      $relcount = $1 + 0;
    } elsif (/.* PLTRELSZ *([0-9]*).*/) {
      $pltrelsz = $1 + 0;
    }
  }
  close (READELF);

  open (READELF, "eu-readelf -r $ARGV[$cnt] |") || die "cannot open $ARGV[$cnt]";
  while (<READELF>) {
    chop;
    if (/.*JU?MP_SLOT *0+ .*/) {
      ++$extplt;
    }
  }
  close (READELF);

  if (open (PRELINK, "/usr/sbin/prelink -p 2>/dev/null | fgrep \"$fullpath\" |")) {
    while (<PRELINK>) {
      ++$users;
    }
    close(PRELINK);
  } else {
    $users = -1;
  }

  printf ("%s: %d relocations, %d relative (%d%%), %d PLT entries, %d for local syms (%d%%)",
	  $ARGV[$cnt], $relent == 0 ? 0 : $relsz / $relent, $relcount,
	  $relent == 0 ? 0 : ($relcount * 100) / ($relsz / $relent),
	  $relent == 0 ? 0 : $pltrelsz / $relent,
	  $relent == 0 ? 0 : $pltrelsz / $relent - $extplt,
	  $relent == 0 ? 0 : (($pltrelsz / $relent - $extplt) * 100) / ($pltrelsz / $relent));
  if ($users >= 0) {
    printf(", %d users", $users);
  }
  printf("\n");
}

--=-KyksD48aoKDI2svnMZer--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
