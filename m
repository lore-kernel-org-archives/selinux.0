Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5DIh29N003906
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2012 14:43:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 13 Jun 2012 14:42:59 -0400
From: David Quigley <selinux@davequigley.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        casinee app
 <appcasinee@gmail.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: "operation not support" when execute #restorecon -R /
In-Reply-To: <1339612617.13501.16.camel@moss-pluto.epoch.ncsc.mil>
References: <CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
 <ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
 <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
 <c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
 <CAO-AVB7QdNtzoZWKQ0R0mBOrzEFy5e1kovZs5CVW-795K6WpkQ@mail.gmail.com>
 <4FD8BCEB.30904@schaufler-ca.com>
 <f65dde7d2b1b153b983162861effab4a@countercultured.net>
 <1339612617.13501.16.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <95d90c885c343f37ebe7be374bacd9b8@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/13/2012 14:36, Stephen Smalley wrote:
> On Wed, 2012-06-13 at 14:17 -0400, David Quigley wrote:
>> That being said the ideal person to contact to find out why it isn't
>> working would be James Morris. If he wants to keep the patches up to
>> date he is welcome to but this was a stop gap method until we got
>> Labeled NFS in the kernel. It was determined that NFSv4 with Labeled 
>> NFS
>> was the proper solution to the problem.
>
> Isn't the problem just that he needs to modify his policy so that
> SELinux knows to use the xattr support for nfsv3?  fs_use_xattr


I can't say for sure but that would definitely be the first place to 
start. I'm not sure if that code path has changed since James released 
the patches. If it hasn't then its just a simple policy change. If it 
has his initial assumptions might not hold true and he may need to 
modify something in the NFS mount handling code.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
