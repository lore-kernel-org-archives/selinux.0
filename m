Subject: tcp_send errors
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1038926427.19852.19.camel@phobos.hallcomp.com>
Mime-Version: 1.0
Date: 03 Dec 2002 09:40:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have the latest lsm (as per the NSA site) installed on a fresh RH8.0
install and I am getting errors trying to forward packets through it. 
Is there something I need to change in the policy to premit forwarding
or is this just a RH8.0 problem not present in the 7.X versions? I do
not have the exact errors since the ssh apparently isn't working
properly, but they were tcp_send errors and I can provide those later.  

Also I have four interfaces and I'm thinking I remember there being a
problem with more than two, so is this still a problem?

Lastly I've noticed a few others having trouble with RH8.0 and I have a
whole lot more problems than I did with a RH7.3 machine so my question
is does anyone have other distros they are running SELinux on and like
how it is working out?  Russell I know you are doing lots of good for
debian, but what about others? Mandrake? Slackware? etc. etc.?

Timothy,




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
