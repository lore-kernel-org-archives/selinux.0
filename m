Content-Type: text/plain;
  charset="us-ascii"
From: Bill Laut <wlsel@verizon.net>
To: SELinux@tycho.nsa.gov
Subject: SELinux, KDE, and honeypots
Date: Tue, 8 Jul 2003 23:03:22 -0400
MIME-Version: 1.0
Message-Id: <200307082303.22083.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


(1)  Once I finish cleaning up my gateway/router's policy, I would like to 
migrate my workstation to SELinux so that I can allow Mozilla to run 
Javascripting and/or plugins without the fear of my workstation being 
compromised.  In reading through the archive, it seems the only thing that 
needs to be modified is kdm.  Is this a correct assumption, or should I 
expect it to be more involved than that?

(2)  My earlier encounter with the avc network messages inspired an idea for a 
possible Intrusion Detection System.  For example, consider a typical server 
running Apache, Sendmail, and Qpopper; to which the sysadmin wants to know if 
the server is ever compromised, and if so how was it accomplished.

The idea I had was to create a pseudo-device driver that leverages NetFilter 
to output all traffic from all TCP streams to a user-mode daemon that writes 
the packets for each stream into their own separate disk files (and governing 
the throughput if need be so that the transcribing daemon can keep up with 
the traffic).  If no security violations are reported during the lifetime of 
the TCP stream, then when it is closed the transcript is moved to a directory 
where it remains for some period of time (perhaps for auditing purposes) 
before being routinely deleted.

If, however, any security violations are reported they are recorded into the 
transcript file in sequence with the TCP packets, and then when the stream is 
closed the completed file is moved into a permanent directory for later 
analysis.  

The general idea is that if some hitherto unknown weakness in a daemon is 
exploited, that the transcript file would allow an analyst to speedily 
determine the exploit vector and thereby facilitate patching the exploit.  
Does this idea sound reasonable?  Has someone already done it using SELinux?  
If not, how would you improve it?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
