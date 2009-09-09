Subject: Re: setfiles leaks file descriptors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4AA6E4E2.1000303@redhat.com>
References: <4AA6E4E2.1000303@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 07:43:22 -0400
Message-Id: <1252496602.13634.585.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 19:12 -0400, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=521682
> 
> Patch to fix is included.

Not relevant anymore to upstream since the corresponding code was
removed from setfiles when it was rewritten.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
