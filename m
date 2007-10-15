Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FKJ99J012450
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 16:19:09 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FKJ8BC013664
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 20:19:08 GMT
Subject: Re: configured virtual environment with SElinux
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: shahbaz khan <shazalive@gmail.com>
Cc: Jax <cybercorecentre@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <7b740b700710151033h77f51349rcaef35571da0646f@mail.gmail.com>
References: <4710018B.20607@gmail.com>
	 <1192455622.2913.3.camel@localhost.localdomain>
	 <7b740b700710151033h77f51349rcaef35571da0646f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 14:36:15 -0400
Message-Id: <1192473375.2913.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-15 at 22:33 +0500, shahbaz khan wrote:
> On 10/15/07, Karl MacMillan <kmacmillan@mentalrootkit.com> wrote: 
>         On Sat, 2007-10-13 at 01:21 +0200, Jax wrote:
>         > Hi guys,
>         >
>         > I still learning many thing in selinux and I want to ask you
>         about is 
>         > there any image where someone already configured selinux for
>         many
>         > application? It can be vmware, uml, openvz whatever, but it
>         would help
>         > me a lot in learning, and understanding selinux by examples
>         because the 
>         > theory itself incredibly boring. I read many docs on the
>         site and I
>         > don't feel I making any progress in this.
>         >
>         > Thanks
>         >
>         > Jax
>         >
>         
>         Installing Fedora (or one of the other supported distros) will
>         get you a 
>         fully configured selinux system.
>  
> Fedora will give you an example system but you will need to download
> the reference policy from Tresys website. Refference policy is a nice
> division of policy into a base and then modular policy per package. It
> will enable you to understand the way the SELinux team handles policy.
> If I can remember correctly they did some work on Xen and VMware.
> Check out the mailing list archives as well. You might find something
> useful there. The theory might be boring to you but you will always
> need some reference material to grip on to the concepts and policy
> clearly. 
> 

The reference policy is included with recent Fedora version. yum install
selinux-policy-devel.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
