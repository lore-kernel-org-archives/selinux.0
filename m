Subject: Re: compiling errors!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: mina elnino <potushka@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>
	 <CIEOKAFOMGPNJIPMMMAHMELCCBAA.remmolt@zwartsenberg.eu>
	 <f7d5075c0907290626t1c772fd3l9f60c7a710c6152@mail.gmail.com>
	 <f7d5075c0907290704x9b2b426sb6c3bb928a11a98b@mail.gmail.com>
	 <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil>
	 <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 08:22:39 -0400
Message-Id: <1248956559.11627.105.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 09:51 +0430, mina elnino wrote:
> well, i have to say that i went through the steps in:
> 
> http://danwalsh.livejournal.com/26428.html
> 
> and at last i realized that this page is for the ones who want to make
> policies from the source. now i have packages:
> 
> $ ls ~/rpmbuild/RPMS/noarch/
> selinux-policy-3.6.12-62.fc11.noarch.rpm
> selinux-policy-doc-3.6.12-62.fc11.noarch.rpm
> selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm
> selinux-policy-mls-3.6.12-62.fc11.noarch.rpm
> selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm
> 
> none of them is the source policy package. i mean i need that old m4
> macros, "*.te" files and "policy.conf" which could be installed by
> "selinux-policy-targeted-source" or "selinux-policy-strict-source" in
> fc4.

If you want to just unpack the source tree along with any
Fedora-specific patches applied, you can do:
rpm -i selinux-policy*.src.rpm
cd ~/rpmbuild/SPECS
rpmbuild -bp selinux-policy.spec
cd ../BUILD/serefpolicy*
Then you can build it in the usual manner.

You can also clone the upstream refpolicy repository if you want:
git clone http://oss.tresys.com/git/refpolicy.git
cd refpolicy

Note however that Fedora policy is built modular rather than monolithic,
so there is no policy.conf file per se.  But if you run make with the
default build.conf, you'll end up with a policy.conf file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
