Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2FBOxvF001314
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2011 07:25:00 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p2FBOuKV001579
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2011 11:24:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: libselinux version bump past 99
Date: Tue, 15 Mar 2011 22:24:50 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <4D76AD1C.8080901@tycho.nsa.gov> <4D7EA42A.2030802@windriver.com>
In-Reply-To: <4D7EA42A.2030802@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201103152224.51076.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Mar 2011, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> On a related note, is there a reason why the shared objects don't
> track a similar versioning number?    We came across a situation
> where an internal update added a new dir for libs.   But note the
> shared objects are hard coded to version 1,  and the old selinux
> libs just happened to be found 1st.   Which leads to a cryptic
> internal selinux error message like this:

So what's the plans for libselinux at the moment?  Are we going to get a .so 
version change in the near future?

I'm trying to build version 2.0.98 on Debian and I get the following error 
when going from 2.0.96.  If we are going to increase the .so version in the 
near future then I won't bother trying to solve this right now.  Although from 
a quick inspection of the code it doesn't seem likely that this will cause any 
problems, it seems that selabelsublist should never have been exported and is 
extremely unlikely to have been used.

dpkg-gensymbols: warning: 
/usr/src/libselinux/libselinux-2.0.98/debian/libselinux1/DEBIAN/symbols 
doesn't match completely debian/libselinux1.symbols
--- debian/libselinux1.symbols (libselinux1_2.0.98-1_i386)
+++ dpkg-gensymbolszEQkRf       2011-03-15 21:36:52.486698524 +1100
@@ -136,7 +136,7 @@
  selabel_lookup_raw@Base 2.0.65
  selabel_open@Base 2.0.65
  selabel_stats@Base 2.0.65
- selabelsublist@Base 2.0.82
+#MISSING: 2.0.98-1# selabelsublist@Base 2.0.82
  selinux_binary_policy_path@Base 1.32
  selinux_booleans_path@Base 1.32
  selinux_check_passwd_access@Base 1.32

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
