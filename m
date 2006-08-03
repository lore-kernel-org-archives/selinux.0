Subject: Re: Patch to fix segfault in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44D0B287.1040500@redhat.com>
References: <44D0B287.1040500@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:35:38 -0400
Message-Id: <1154615738.32479.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 10:11 -0400, Daniel J Walsh wrote:
> * Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-5
> - only build non-fpic objects with -mno-tls-direct-seg-refs
> 
> * Tue Aug  1 2006 Jeremy Katz <katzj@redhat.com> - 1.30.19-4
> - build with -mno-tls-direct-seg-refs on x86 to avoid triggering
>   segfaults with xen (#200783)  

What's really at fault here, libselinux or xen?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
