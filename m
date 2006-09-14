Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EEqhH7005664
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 10:52:43 -0400
Received: from mail2.secpay.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8EEqGv1002331
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 14:52:16 GMT
Received: from localhost (secpay.com [127.0.0.1])
	by mail2.secpay.com (Postfix) with ESMTP id AB78313FFC6
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 15:52:42 +0100 (BST)
Received: from mail2.secpay.com ([127.0.0.1])
	by localhost (mail2.secpay.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLEp0fAxELXR for <selinux@tycho.nsa.gov>;
	Thu, 14 Sep 2006 15:52:41 +0100 (BST)
Received: from localhost.localdomain (tonbridgesecpay.force9.co.uk [84.92.73.251])
	by mail2.secpay.com (Postfix) with ESMTP id 1004A14000C
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 15:52:40 +0100 (BST)
Date: Thu, 14 Sep 2006 15:52:23 +0100
From: Stuart James <stuart@secpay.com>
To: selinux@tycho.nsa.gov
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
Message-ID: <20060914155223.0f8f31ea@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Sep 2006 08:52:34 -0400
Daniel J Walsh <dwalsh@redhat.com> wrote:

> We have been having some meetings to discuss how we can use this
> stuff in the real world (IE Non MLS), and I think the current
> implementation is coming up short.  The discussions I have seen have
> talked about using getpeercon to look at the other end of the
> connections, but this is not in the spirit of SELinux where
> modification of the applications should not be necessary to secure
> the environment.
> 
> 
> Lets look at some real world situations where having better controls
> on the network would work and someone explain to me how Joe Average 
> SysAdmin will set them up.
> 

> 
> =======================================================
> 
> If someone was to pass a law and make me the King of SELinux, The way 
> this would happen is that iptables would be extended to add a -t 
> SecurityContext flag, which I then could simple SELinux rules to set 
> this up in a lanquage that most Sysadmins of Linux boxes could
> readily understand.
> 

If I understand it correctly, secmark is an additional type of
selinux context that needs to be modified in the selinux policy
to add the ability for the iptables rule to function correctly? 

Is there currently a way of labeling the type of iptable ruleset? such
as if i were to create a chain called "iptables -N mychain", could i
then label then chain when creating it, such as with 
"iptables -A mychain -p tcp -m tcp --dport 80 -j SecurityContext"
and would SecurityContext take over from the -j ACCEPT ?

As i was looking through the
http://people.redhat.com/jmorris/selinux/secmark/ this tends to make
agree with your statement of having the ability to add the context into
the iptables rule, is this a current ability of iptables or only on
patched systems?

Another issue which has arisen while moving from Fedora core 3 to
above, was prior to newer versions of kernel / openswan and iptables,
if you were using the IPsec device as also a Masquerading device,
complex rulesets to exclude masquerading to destination networks
provided by the ipsec tunnel have to be specified specifically as
ACCEPT for POSTROUTING prior to POSTROUTING of outbound traffic
destined to the internet. 

Assuming now you have ipsec tunnels to 192.168.0.0/16
For example now we currently use this on FC4/5

-A POSTROUTING -d 192.168.0.0/16 -o eth0 -j ACCEPT

Prior to Fedora core 4
-A POSTROUTING -s x.x.x.x/24 -d !
192.168.0.0/255.255.0.0 -o eth0 -j MASQUERADE

Assuming now you tunnels to 192.168.0.0/16 and 10.10.10.0/24
The following works on FC4/5, not on FC3
-A POSTROUTING -d 192.168.0.0/16 -o eth0 -j ACCEPT
-A POSTROUTING -d 10.10.10.0/24 -o eth0 -j ACCEPT

And on FC3 you are limited to
-A POSTROUTING -s x.x.x.x/24 -d !
192.168.0.0/255.255.0.0 -o eth0 -j MASQUERADE
-A POSTROUTING -s x.x.x.x/24 -d !
192.168.0.0/255.255.0.0 -o eth0 -j MASQUERADE


Although this is an improvement with the older way, if you had
multiple ipsec connections to more then just the 192.168.0.0/16
network your initial POSTROUTING rule would match, and traffic destined
for say 10.10.10.0/24 for would also get masqueraded to the internet

With the current distribution of Fedora latest selinux policy two IPsec
devices connected running in enforcing mode will not talk across the
network. I have added these audit2allows to my policy for it to work
but unfortunately i will have to redo it to provide you with the
correct avc messages to hopefully get ipsec(openswan) running in
enforcing mode for fc5 and above, as currently if you were trying to
set it up it would not work as required.


-- 
Stuart James
Systems Administrator
DDI - (44) 0 1723 300205
RHCE - RHEL4
CERT# 804005316914471 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
