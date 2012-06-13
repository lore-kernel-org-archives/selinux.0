Message-ID: <1339612617.13501.16.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: "operation not support" when execute #restorecon -R /
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Quigley <selinux@davequigley.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        casinee app
 <appcasinee@gmail.com>, SE-Linux <selinux@tycho.nsa.gov>
Date: Wed, 13 Jun 2012 14:36:57 -0400
In-Reply-To: <f65dde7d2b1b153b983162861effab4a@countercultured.net>
References: 
	<CAO-AVB7hN1sODoEyE3pXv0mz0SN1KagdNFcHrb1Tt24DC+_dDA@mail.gmail.com>
	 <ff7c28e8f022fc5bd217bb5ed7321fa6@countercultured.net>
	 <CAO-AVB4D4=LLMqaifLqOE8v6APndkMkkHwspx4+kazcs3Fo=ow@mail.gmail.com>
	 <c2d372aa61ec3547cbe08b3fa3f61fc0@countercultured.net>
	 <CAO-AVB7QdNtzoZWKQ0R0mBOrzEFy5e1kovZs5CVW-795K6WpkQ@mail.gmail.com>
	 <4FD8BCEB.30904@schaufler-ca.com>
	 <f65dde7d2b1b153b983162861effab4a@countercultured.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-13 at 14:17 -0400, David Quigley wrote:
> That being said the ideal person to contact to find out why it isn't 
> working would be James Morris. If he wants to keep the patches up to 
> date he is welcome to but this was a stop gap method until we got 
> Labeled NFS in the kernel. It was determined that NFSv4 with Labeled NFS 
> was the proper solution to the problem.

Isn't the problem just that he needs to modify his policy so that
SELinux knows to use the xattr support for nfsv3?  fs_use_xattr 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
