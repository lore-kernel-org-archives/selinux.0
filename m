Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p44HYsrg000651
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 13:34:54 -0400
Received: from smtp110.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p44HYqsZ007311
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 17:34:53 GMT
Message-ID: <4DC18E3B.2000104@schaufler-ca.com>
Date: Wed, 04 May 2011 10:34:51 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: John Johansen <john.johansen@canonical.com>,
        Tyler Hicks <tyhicks@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        kirkland@canonical.com, ecryptfs-devel@lists.launchpad.net,
        eparis@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        viro@zeniv.linux.org.uk, apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
References: <201104291139.37489.roberto.sassu@polito.it> <4DC088A8.4000300@schaufler-ca.com> <4DC09688.7090509@canonical.com> <201105041047.57161.roberto.sassu@polito.it>
In-Reply-To: <201105041047.57161.roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/4/2011 1:47 AM, Roberto Sassu wrote:
> On Wednesday, May 04, 2011 01:58:00 AM John Johansen wrote:
>> ....
>> I have to agree with Casey, Generally looping back through the vfs should
>> be using the user's credentials.  This doesn't even stop you opening the
>> lower file with a different set of permissions (eg.  rw while the upper
>> is opened with r).
> Hi Casey and John
>
> my patch set does not modify this behavior:  VFS calls on upper inodes
> made by user processes and VFS calls (read/write) made by eCryptfs
> on lower inodes still use the user's credentials.
>
> In addition, SELinux provide a model for file descriptors. They may be
> opened by another subject (which provided its own credentials) and
> other processes need the 'use' permission for those file descriptors
> other than permissions for related inodes.
>
> This means that, even if eCryptfs opens lower inodes with its own
> credentials, user processes still need permissions to read/write both
> upper and lower inodes.
>
> One benefit of allowing eCryptfs to provide its own credentials is that
> user processes must have granted only strictly required permissions.
>
> Roberto Sassu

My point is that you should be able to achieve all of what you
say you want to do without introducing the LSM changes you are
proposing.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
