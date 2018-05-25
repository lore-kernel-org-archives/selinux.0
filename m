To: bhawna goel <bhawnagoel13@gmail.com>, selinux@tycho.nsa.gov
References: <CABCvxxqSZa8kqtjvPy0601REvawdbH60VpwUEAwGQp9dky8meQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d24fc7c1-31b2-132f-49d4-4c612bf0816e@tycho.nsa.gov>
Date: Fri, 25 May 2018 08:24:09 -0400
MIME-Version: 1.0
In-Reply-To: <CABCvxxqSZa8kqtjvPy0601REvawdbH60VpwUEAwGQp9dky8meQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Selinux load_policy command on chrooted partition is loading
 policy on active partition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/25/2018 04:08 AM, bhawna goel wrote:
> Hi Team,
> 
> We are facing an issue with load_policy command on Centos 7.4.. Need to understand what it exactly does.
> 
> We have Centos 7.4 machine which have two partitions .
> Ist partition (partA) have all the policies with unconfined and when we are installing second partition (partB) we are adding all the policies for sysadm. 
> During installation of partB below command is getting executed from partA
> chroot partB load_policy -qi.
> 
> Just after executing this command partA stops working with unconfined policies . partA giving denials which was working before executing this command.
> 
> Just to recover my system i executed load_policy -q in partA and it gets back to normal.
> 
> I wanted to understand what exactly load_policy do . Why my partA stopped working when load_policy is executed in partB .Is this expected behavior or there is some issue.
> 
> Thanks in advance.

I thought I answered this yesterday, but let's try again: load_policy always loads the active policy as defined by /etc/selinux/config relative to its root. So if you perform a chroot /path/to/partB load_policy it will load the policy from /path/to/partB/etc/selinux into the kernel.  And then your partA will stop working.  There is only one kernel policy; it isn't relative to any particular root.  Don't load policy from partB unless you are actually booting from partB.
