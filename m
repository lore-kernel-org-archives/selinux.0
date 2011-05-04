Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p44HgfNM001135
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 13:42:41 -0400
Received: from smtp109.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p44HgdaJ024183
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 17:42:40 GMT
Message-ID: <4DC1900D.3010804@schaufler-ca.com>
Date: Wed, 04 May 2011 10:42:37 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: Tyler Hicks <tyhicks@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        kirkland@canonical.com, ecryptfs-devel@lists.launchpad.net,
        eparis@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        viro@zeniv.linux.org.uk, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com, bfields@fieldses.org, neilb@suse.de,
        linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
References: <201104291139.37489.roberto.sassu@polito.it> <201105021053.54031.roberto.sassu@polito.it> <4DC088A8.4000300@schaufler-ca.com> <201105041119.57493.roberto.sassu@polito.it>
In-Reply-To: <201105041119.57493.roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/4/2011 2:19 AM, Roberto Sassu wrote:
> On Wednesday, May 04, 2011 12:58:48 AM Casey Schaufler wrote:
>> On 5/2/2011 1:53 AM, Roberto Sassu wrote:
>> ...
>>>> Right, but what I don't understand is why you can't use existing
>>>> mechanisms to achieve this? NFS manages (mostly).
>>> Please, can you explain better this thought?
>> NFS provides a network "view" of an ext4 (or any type for that matter)
>> filesystem. NFS does not support extended attributes, but there has been
>> ongoing work on that. It seems that if NFS does not require the kind
>> of changes you are requesting you shouldn't either.
> I'm not familiar with NFS, so i cannot answer about this scenario.

NFS provides the historical and prototypical example of a layered
filesystem. If you are implementing a layered filesystem and have
not researched NFS you are missing out on the bulk of the experience
and wisdom on the subject.

> I'm adding in CC also the NFS mantainers and the mailing list so
> that they can express their point of view. The whole thread is
> available at:
>
> https://lkml.org/lkml/2011/4/27/201
>
> Roberto Sassu


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
