Message-ID: <3F67CC08.9050106@diyab.net>
Date: Tue, 16 Sep 2003 22:50:48 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Frank Mayer <mayerf@tresys.com>,
   Dave Caplan <dac@tresys.com>
Subject: Re: Policy source and initial ramdisk
References: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
In-Reply-To: <1063747354.25176.44.camel@colossus.columbia.tresys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> It appears that users are required to call mkinitrd whenever the policy
> is modified. If this is the case it seems that users might be unaware
> that make install /etc/security/selinux/src/policy doesn't change the
> policy loaded during the next boot. Additionally, it is problematic for
> tools that modify the policy source. The quickest solution would be to
> modify the install target to call mkinitrd, but this has some issues
> (like reliably determining the name of the ramdisk image). Does anyone
> have any thoughts about the best way to approach this problem?
> 
> Karl

I think everything needed to make the initrd should be in with the 
policy source directory.

1) It will eliminate problems with distribution differences.

2) Since the initrd is required the user should have everything he/she 
needs when the selinux archives are downloaded.

3) We can set a standard initrd image name and note it in the README.

The user can still make a different initrd with different contents and a 
different name etc. if they want.

Also there are distributions that don't include mkinitrd and I'm willing 
to be there are slight differences between the actual script of the 
distros that do.  Just have a selinux specific version installed into 
/usr/local/selinux/sbin with the policycore utils or something.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
