Date: Thu, 15 Apr 2004 18:16:59 -0500
From: tdbrown@uiuc.edu
To: SELinux@tycho.nsa.gov
Cc: Michael Ihde <ihde@uiuc.edu>
Subject: SELinux security in the face of single bit errors
Message-ID: <20040415231659.GG4773@peach.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm taking a graduate level Fault Tolerant Computing course.  My partner 
and I intend on injecting single bit faults into the data and text 
sections of SELinux to see if such faults can compromise system 
security. While it is obvious that a single bit error in some 
structures, such as the AVC allowed field or the selinux_enforcing, can 
open an SELinux system for a period of time.  We want to look for less 
obvious holes which may be realized by a single bit flip (also called 
soft-errors). Our plan is to run a User-mode SELinux kernel and use the 
ptrace interface to inject errors in the SELinux text section and/or 
data section. The kernel will execute a test program as init which will 
attempt to violate the SELinux policy by writing to a protected file 
with mod=777 and then shutdown the system.  Given more time we would 
like to violate other  things than simple file permissions.

We are aware that the impact of a transient single bit errors depends on 
how long the bit-error lasts.  In the case of an bit error in the AVC it 
may only last a short time (when the avc entry is overwritten) or a long 
time.  Bit errors in the text segment may last longer depending on the 
particulars of the OS. We are not planning to measure the time that a 
particular bits creates a vulnerability, we have limited time to get 
results and the parameter is heavily dependant on the enviroment.  We
will include this cavot in our report.

Our project was inspired by the following papers:

   * "An Experimental Study of Security Vulnerabilities Caused by 
Errors"
     Jun Xu, Shuo Chen, Abigniew Kalbarczyk, Ravishankar K. Iyer

   * "Using Memory Errors to Attack a Virtual Machine", Sudhakar
     Govindavajhala, Andrew W. Appel

   * "Framework for Testing the Fault-Tolerance of Systems Including OS
     and Network Aspects", Kerstin Buchacker, Volkmar Sieh (HASE '01)

If you have any comments or suggestions we would love to hear them.  To 
save traffic on the mailing list you can add your comments to
 
http://www.randomwalking.com/cgi-bin/kwiki/index.cgi?ECE442OutsideComments

~Michael Ihde & Tom Brown


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
