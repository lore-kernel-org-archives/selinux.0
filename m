Subject: Re: Minor change to getsebool.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F035D2.9030307@redhat.com>
References: <45F035D2.9030307@redhat.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 14:47:39 -0500
Message-Id: <1173383259.23674.3.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 11:12 -0500, Daniel J Walsh wrote:
> I am starting to label the booleans and different user roles will only
> be able to manipulate certain booleans.

This brings up a problem.  I'm trying to move booleans/tunables that
only are used in a single module back into that module (see the
booleans-modules branch of refpolicy).  The problem is that genfscon
doesn't currently work in modules.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
