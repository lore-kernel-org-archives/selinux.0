Reply-To: <sunil@liqwidkrystal.com>
From: "sunil" <sunil@liqwidkrystal.com>
To: <SELinux@tycho.nsa.gov>
Subject: Question about SELinux
Date: Thu, 4 Oct 2001 17:57:53 +0530
Message-ID: <000501c14ccf$fe1031e0$5d01a8c0@liqwidkrystal.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

We have the following server requirement:

1. Untrusted users can login into the system and run
    programs that they have written in  a variety of programming languages
    ranging from Java to C++, Ruby, Python, etc. These programs would
    typically be small in size, written by people who are learning these
    technologies. But they could be of all types:
    Socket programs, UI programs, text-mode programs, etc.

2. The users should be able to run only well-behaved programs on the server.
     A well-behaved program would be one that uses reasonable amounts of
CPU,
    disk, network and memory resources and does not try to compromise the
security of the system.
    Therefore, malicious programs of any kind should be quietly terminated.

3. All of this should be possible with minimal overhead incurred from any
monitoring
    infrastructure.

Can I achieve this using SELinux?

Thanks & regards,

Sunil Arvindam

__________________________
Sunil Arvindam
Chief Architect,
Liqwid Krystal,
Pearl House, 9/3 Museum Road,
Bangalore-560001,
India.
Ph: (91) 80-5091789
Fax:(91) 80-5091794
email:sunil@liqwidkrystal.com
__________________________





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
