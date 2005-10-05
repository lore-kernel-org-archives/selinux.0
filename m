Subject: Re: [PATCH] libsepol - assertion invalid destroy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1128436376.28919.10.camel@twoface.columbia.tresys.com>
References: <1128436376.28919.10.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 12:10:53 -0400
Message-Id: <1128528653.24059.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-04 at 10:32 -0400, Joshua Brindle wrote:
> In the case when there were no assertions in the policy, the assertion
> checking function would attempt an invalid destroy of the ebitmaps that had
> not been initialized. Since assertions are stored in avrules, if there
> are no avrules it returns successfully.

Thanks, merged all 8 patches as of libsepol 1.9.11 and checkpolicy
1.27.7.  Including the permission value ones, although I'm not sure it
makes any real difference (just better form, I suppose).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
