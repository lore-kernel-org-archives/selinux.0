Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSHkhIi023185
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 12:46:43 -0500 (EST)
Received: from kandu.netexpress.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSHisGx020989
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 17:44:54 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with
	poptime)
	by smtp804.mail.ukl.yahoo.com with SMTP; 30 May 2004 22:26:34 -0000
Date: Sun, 30 May 2004 22:23:59 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Message-ID: <20040530222358.GD3170@lkcl.net>
References: <20040529214030.GG2851@lkcl.net>
	<tsl4qpxskty.fsf@konishi-polis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <tsl4qpxskty.fsf@konishi-polis.mit.edu>
Cc: SE-Linux <selinux@tycho.nsa.gov>, pam-list@redhat.com
Subject: Re: SE/Linux patch -
	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=249499
Reply-To: Pluggable Authentication Modules <pam-list@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/pam-list>,
	<mailto:pam-list-request@redhat.com?subject=unsubscribe>
List-Archive: </archives/pam-list>
List-Post: <mailto:pam-list@redhat.com>
List-Help: <mailto:pam-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/pam-list>,
	<mailto:pam-list-request@redhat.com?subject=subscribe>
To: nicholas.vermeer@gmail.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 30, 2004 at 04:48:09PM -0400, Sam Hartman wrote:
> I indicated a willingness to work with Russel on selinux integration
> but he never got back to me.  

 oh?

 ah.

 seems like communication has been lost in transit then.

> He asked if I was interested in
> upgrading to PAM 0.77.  I said no because it seemed like a lot of work
> for no significant gain.  

 *thinks*.  lessavalook.

 okay... debian's pam version is 0.76.  SHRIEK there's a stack
 of patches in the debian/patches directory!!  no wonder it'd
 be a lot of work!

 and the NSA's pam patch is against 0.77, and it's 1,934 lines long.

 eep :)

 okay, let's see if it cleanly applies to 0.76.... annnd no it
 doesn't.

 okay, i tried doing a merge, but i am beginning to get into trouble
 on pam_unix_passwd.c.  
 
 for example, in the original 0.76 pam_unix_passwd.c file, there
 is code that does:

 chown(OPW_TMPFILE, 0, 0);
 chmod(OPW_TMPFILE, 0600);

 yet i see no such thing in 0.77.

 but i _do_ see a fchmod(fileno(owfile), st.st_mode).

 and then later on there appear to be inconsistencies when
 the shadow password file is handled in a similar fashion.

 [whoever did that rewrite of pam 0.77, you're a pain! :)

  only kidding.
  
  you introduced a different style "set err = -1; goto end"
  instead of returning an error message immediately: i know
  _why_ it was done, it's to be able to clean-up the selinux
  context at the end of that function which has over five
  return points.

  knowing why doesn't mean i have to like it if it causes a
  patch to happen not to apply against an older version.

  *grump*.  ignore me.

 ]


 i think the mods to unix_chkpwd.c where this a single clash
 in main at the comment "read the nullok/nonull option" are
 more straightforward to resolve.

 it's just these passwd file and shadow file handling patches
 that are... "odd" and don't cleanly apply.



> I indicated willingness to take patches from
> upstream's cvs if they made the selinux work easier but he never
> responded to the offer.

 the only thing i can think of is that a communication thread has
 been lost, somehow, because russell is under the impression that
 pam / selinux integration has stalled.

 
 *click*.

 oh, so you'd be happy for someone (me being the closest victim)
 to attempt a patch against the latest pam cvs rather than
 specifically against 0.77?

 hey, that's worth a shot, because against 0.76 it ain't gonna
 happen - not cleanly, anyway.

 correct me if a quick googling is wrong, but that's
 http://sf.net/projects/pam, yes?



 l.


_______________________________________________
Pam-list mailing list
Pam-list@redhat.com
https://www.redhat.com/mailman/listinfo/pam-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
