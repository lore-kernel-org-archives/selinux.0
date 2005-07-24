Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6O838gA016236
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 04:03:10 -0400 (EDT)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6O7vFRc001201
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 07:57:16 GMT
Received: by wproxy.gmail.com with SMTP id 58so813542wri
        for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 00:58:05 -0700 (PDT)
Message-ID: <4354d32705072400584c426445@mail.gmail.com>
Date: Sun, 24 Jul 2005 10:58:05 +0300
From: =?ISO-8859-1?Q?T=F6r=F6k_Edvin?= <edwintorok@gmail.com>
Reply-To: =?ISO-8859-1?Q?T=F6r=F6k_Edvin?= <edwintorok@gmail.com>
To: selinux@tycho.nsa.gov
Subject: dynamic firewall configuration & program access control to ports
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I would like to write a GUI tool, and I'd like to know if selinux can
solve the low-level issues.
Here it is what I want to do:
- It starts with an existing firewall/selinux config
- I want to authorize access to ports on an individual program basis
- If at runtime a program tries to listen/send on a port, that it is
not (yet) allowed to, then it would ask the user if it wants to allow
it, if yes, then:
   - if the firewall is blocking the port, create an appropriate rule,
and open the port
   - creates the appropriate selinux rule, and updates it
- When the program stops using the port:
  - if the user wanted to allow it for this session only, then it
rolls back the selinux config, otherwise it saves the config
  - if nobody else is using the port, update the firewall (iptables)
to block the port

My question is:
- is selinux able to control access to ports selectively by program?
    - the program access control should be something secure like, not
only by the path of the program, but also by checking its hash (stored
in a secure place, and accessible only by selinux), if the hash
doesn't match, then it doesn't have any rights
- is it possible to notify my program when a program tries to access a
port it doesn't have the right to, or when the hash of the program
doesn't match
- how can I update the selinux policies from my program, without
interfering with custom user configuration (I don't want my GUI to
manage the whole configuration)
- how can I make my program run as non-root user, and still have the
right to modify the selinux config, but without opening potential
security holes?
  - if I make a daemon that changes the config files, and that
communicates with my user program, what means does selinux provide me
to secure this communication:
      - the GUI and daemon will run on the same machine
      - the client can use certificates to authenticate
      - how can I use selinux to further secure this, because a
security hole is found in this communication the entire system will be
easily compromised
- does using selinux have potential security impacts?
- does one have to recompile its kernel, or is it enough if it loads
selinux as a module?(so for example I could distribute the selinux
module for different kernels precompiled, so the users don't have to
recompile the kernel to use selinux and my program)

I appreciate any suggestions, comments, criticism about what I said above.
Thank you for taking the time to read this message.
P.S.: I am new to selinux, so I would appreciate if you could point me
at *must read* documentation related to what I want to do above.
If somebody knows about an app that has similar intentions as mine,
then please tell me, so that we don't duplicate efforts.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
