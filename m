Message-ID: <20050225175717.45835.qmail@web51505.mail.yahoo.com>
Date: Fri, 25 Feb 2005 09:57:16 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Isson on meaning of local socket in ... 
To: SELinux@tycho.nsa.gov
Cc: sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  In subsection 8.1.1 of "Integrating Flexible Support
for Security Policies into the Linux Operating
System", It says:
  "The Linux network component creates two special
purpose sockets for use by the AF_INET protocol
family.The tcp_socket is used to send resets when a
TCP packet is rejected, since there may be no local
socket corresponding to the packet. The icmp socket is
used to send ICMP messages."

  I found that tcp_socket was also setup by local host
in tcp_v4_init(). 
  Then, What does the "local socket" mean, here? 
  Does it refer to "user socket" which is mentioned by
Jmorris ( see
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108407589700679&w=2
)? 
  Or just as an antonym of "foreign socket" or "remote
socket"?

  Thank you.


=====
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
