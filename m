Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v177e5dF009455
 for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2017 02:40:05 -0500
Date: Tue, 07 Feb 2017 18:39:53 +1100
In-Reply-To: <CAB9W1A0Ujj6vFhrQW_i9VcYMQutLTO149wY_TzFt9g9+VSBV3g@mail.gmail.com>
References: <1765226.bX7GAK7GcY@russell.coker.com.au>
 <CAB9W1A0Ujj6vFhrQW_i9VcYMQutLTO149wY_TzFt9g9+VSBV3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: strange avc
To: selinux@tycho.nsa.gov, Stephen Smalley <stephen.smalley@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
From: Russell Coker <russell@coker.com.au>
Message-ID: <8E3358CA-EE57-4E78-B85F-AE117FB099C5@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for the information. That's the Debian/Jessie kernel and it's years too late to get it fixed. Oh well at least it fails closed.

On 26 January 2017 12:22:35 am LHDT, Stephen Smalley <stephen.smalley@gmail.com> wrote:
>On Wed, Jan 25, 2017 at 1:22 AM, Russell Coker <russell@coker.com.au>
>wrote:
>> type=AVC msg=audit(1485258907.829:106): avc:  denied  { 0x800000 }
>for
>> pid=1280 comm="rewrite-0" name="after-the-deadline" dev="vda"
>ino=104107534
>> scontext=system_u:system_r:httpd_t:s0
>> tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
>>
>> I got the above after upgrading a system running kernel 3.16.0 to the
>latest
>> userspace.  Why is this happening?  Is this a bug?
>
>That would be a kernel bug; it means that you have a directory inode
>(for which that permission would be rmdir permission) that is wrongly
>assigned the file security class.  Typically means that the filesystem
>did not set the file mode format bits before security_d_instantiate()
>was called.
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Nexus 6P with K-9 Mail.
