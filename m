Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0PDXMxW010550
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 08:33:24 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so11863866itd.1
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 05:22:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1765226.bX7GAK7GcY@russell.coker.com.au>
References: <1765226.bX7GAK7GcY@russell.coker.com.au>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Wed, 25 Jan 2017 08:22:35 -0500
Message-ID: <CAB9W1A0Ujj6vFhrQW_i9VcYMQutLTO149wY_TzFt9g9+VSBV3g@mail.gmail.com>
Subject: Re: strange avc
To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 25, 2017 at 1:22 AM, Russell Coker <russell@coker.com.au> wrote:
> type=AVC msg=audit(1485258907.829:106): avc:  denied  { 0x800000 } for
> pid=1280 comm="rewrite-0" name="after-the-deadline" dev="vda" ino=104107534
> scontext=system_u:system_r:httpd_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
>
> I got the above after upgrading a system running kernel 3.16.0 to the latest
> userspace.  Why is this happening?  Is this a bug?

That would be a kernel bug; it means that you have a directory inode
(for which that permission would be rmdir permission) that is wrongly
assigned the file security class.  Typically means that the filesystem
did not set the file mode format bits before security_d_instantiate()
was called.
