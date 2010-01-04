Subject: Re: Apparent memory leak in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <9ae48b020912301632u6d69e445tf2dd33d3afe9ca04@mail.gmail.com>
References: <9ae48b020912301632u6d69e445tf2dd33d3afe9ca04@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 Jan 2010 16:36:56 -0500
Message-Id: <1262641016.28009.167.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-12-30 at 16:32 -0800, Ed Swierk wrote:
> When I run the following on a F12 system booted with selinux=0, the
> tcmalloc heap checker complains about a leak somewhere in libselinux:
> 
> $ HEAPCHECK=normal LD_PRELOAD=/usr/lib64/libtcmalloc.so.0
> /usr/bin/python -c 'import _ssl'
> 
> Leak check _main_ detected leaks of 120 bytes in 1 objects
> The 1 largest leaks:
> Leak of 120 bytes in 1 objects allocated from:
>        @ 0x3bf9866589 _IO_getdelim
>        @ 0x3bfb40ca53 set_selinuxmnt
>        @ 0x3bfb414fe6 string_to_security_class
>        @ 0x3bfb404cdb _init
>        @ 0x7fff4bdfa8ed 0x00007fff4bdfa8ed
> 
> No leak is detected when I run this with selinux enabled. My system
> has libselinux-2.0.87-1.fc12 installed.

Likely introduced by Eric's short cut for checking /proc/filesystems and
bailing immediately in the non-selinux case.  Try this:

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index ecb3199..4d010dc 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -59,8 +59,10 @@ static void init_selinuxmnt(void)
 	}
 	fclose(fp);
 
-	if (!exists)
+	if (!exists) {
+		free(buf);
 		return;
+	}
 
 	/* At this point, the usual spot doesn't have an selinuxfs so
 	 * we look around for it */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
