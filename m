Message-ID: <51002C72.1000100@tycho.nsa.gov>
Date: Wed, 23 Jan 2013 13:31:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jan Stancek <jstancek@redhat.com>
CC: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running
 on ext[234]
References: <286629059.3171068.1358964951492.JavaMail.root@redhat.com>
In-Reply-To: <286629059.3171068.1358964951492.JavaMail.root@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/23/2013 01:15 PM, Jan Stancek wrote:
> That diff looks to be addressing same issue, so there shouldn't
> be need for another patch.
>
> I'm guessing we are not using same repo.
> $ git remote -v
> origin  git://git.selinuxproject.org/~serge/selinux-testsuite.git (fetch)
> origin  git://git.selinuxproject.org/~serge/selinux-testsuite.git (push)
> $ git pull
> Already up-to-date.
> $ grep "errno" -r tests/ioctl/
> $
>
> Can you share your git uri please?

Same repo, but this is a local change not yet committed in my working 
copy.  I'm guessing that I forgot to send it or it just never got applied.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
