From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: User Policy Setup
Message-ID: <1008605922.3c1e1ae244f20@mail.outstep.com>
Date: Mon, 17 Dec 2001 11:18:42 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I am very new to setting up and using SELinux so please forgive the dumb 
questions, ok.

I am still trying to work out my issues with getting the network working as I 
am getting messages like "cannot send dump request" and "Error adding address 
192.168.1.5 for eth0".

My question is really about setting up the user policies. I have a special 
project in which I need to confile the users to their HOME directories so that 
they can NEVER navigate out of them. I also need to allow them to run just a 
single application such as StarOffice, but still not let them navigate out of 
their HOME directories even through the application.

Could someone please help to tell me how I might be able to set up some 
policies like this?

Any help would be greatly appreciated,
Thanks,
Lonnie

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
