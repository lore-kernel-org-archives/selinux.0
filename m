Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OBlnrT025422
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:47:49 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OBl2MZ028404
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:47:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patch for firefox
Date: Tue, 24 Aug 2004 21:47:44 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823215636.GD13677@lkcl.net>
In-Reply-To: <20040823215636.GD13677@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gryKBJ7H47GxuJp"
Message-Id: <200408242147.44485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_gryKBJ7H47GxuJp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Aug 2004 07:56, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> the attached patch is required for firefox 0.9.3 to run under debian
> (and other oses?)
>
> the reason for the patch is because someone decided to write a
> script around firefox called firefox-bin that does some LD_LIBRARY_PATH
> messing to keep /usr/lib/mozilla/blah separate.
>
> that this [script] messes up kde from being able to re-run firefox-bin
> for session management because the real binary is fired up without the
> correct LD_LIBRARY_PATH doesn't seem to have occurred to anyone, but
> that's another story...

Try the attached mozilla.fc.  It's got the latest stuff from the CVS plus a 
change equivalent to the one you made.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_gryKBJ7H47GxuJp
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mozilla.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mozilla.fc"

#  netscape/mozilla
HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
/usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
/usr/bin/epiphany-bin   --	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-[0-9].* --	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-bin-[0-9].* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/netscape/.+/communicator/communicator-smotif.real -- system_u:object_r:mozilla_exec_t
/usr/lib(64)?/netscape/base-4/wrapper -- system_u:object_r:mozilla_exec_t
/usr/lib(64)?/mozilla[^/]*/reg.+	--	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t

--Boundary-00=_gryKBJ7H47GxuJp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
