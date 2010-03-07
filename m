Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o27Cgrpp029537
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 07:42:53 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o27CgYCc015887
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 12:42:34 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o27Cgpcb031075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 07:42:52 -0500
Received: from localhost.localdomain (vpn-9-57.rdu.redhat.com [10.11.9.57])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o27CgmGH016705
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 07:42:50 -0500
Message-ID: <4B939F47.7050704@redhat.com>
Date: Sun, 07 Mar 2010 07:42:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: init problem
References: <20100307101505.GA3587@myhost.felk.cvut.cz>
In-Reply-To: <20100307101505.GA3587@myhost.felk.cvut.cz>
Content-Type: multipart/mixed;
 boundary="------------070104010506080908020801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070104010506080908020801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2010 05:15 AM, Michal Svoboda wrote:
> Hello,
>
> I just tried to boot a selinux installation in the plain old way (ie.
> without initramfs) and it seems there is a bug in the init mechanism.
> Sysvinit has a
>
> #ifdef WITH_SELINUX
>          if (getenv("SELINUX_INIT") == NULL&&  !is_selinux_enabled()) {
>            putenv("SELINUX_INIT=YES");
>            if (selinux_init_load_policy(&enforce) == 0 ) {
>              execv(myname, argv);
>
> whereas the is_selinux_enabled man page says "returns 1 if SELinux is
> running or 0 if it is not.".
>
> The problem is that init is the first process and at that very early
> point neither /selinux nor /proc is mounted. The function uses these to
> determine the state of things and if it can't it returns a -1, which is
> an undocumented value and thus a value not accounted for.
>
> So I think that either is_selinux_enabled should return 0 if it can't
> tell (or use some other mechanism to tell), or -1 should be documented
> in the man page and the sysvinit code should be changed to read
>
>    if (getenv("SELINUX_INIT") == NULL&&  (0 == is_selinux_enabled())) {
>                                           ^^^^
>
> Michal Svoboda
>    
man is_selinux_enabled()
...
        is_selinux_enabled  returns  1 if SELinux is running or 0 if it 
is not.
        May change soon.
...
russell@coker.com.au            1 January 2004           
is_selinux_enabled(3)

I guess it depends on your definition of soon.

/usr/include/selinux/selinux.h  has

/* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if 
we get an error. */
extern int is_selinux_enabled(void);

Attached patch to fix man page.



--------------070104010506080908020801
Content-Type: text/plain;
 name="libselinux-manpage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-manpage.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_selinux_enabled.3 libselinux-2.0.92/man/man3/is_selinux_enabled.3
--- nsalibselinux/man/man3/is_selinux_enabled.3	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.92/man/man3/is_selinux_enabled.3	2010-03-07 07:40:57.000000000 -0500
@@ -1,4 +1,4 @@
-.TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
+.TH "is_selinux_enabled" "3" "7 Mar 2010" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 is_selinux_enabled \- check whether SELinux is enabled
 
@@ -14,6 +14,7 @@
 .SH "DESCRIPTION"
 .B is_selinux_enabled
 returns 1 if SELinux is running or 0 if it is not. 
+On error, \-1 is returned.
 
 .B is_selinux_mls_enabled
 returns 1 if SELinux is running in MLS mode or 0 if it is not. 

--------------070104010506080908020801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
