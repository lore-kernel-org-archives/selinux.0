Date: Fri, 16 Apr 2004 13:45:16 -0500
From: Tom Brown <tdbrown@uiuc.edu>
To: Ed Street <edstreet@street-tek.com>
Cc: SELinux@tycho.nsa.gov, "'Michael Ihde'" <ihde@uiuc.edu>
Subject: Re: SELinux security in the face of single bit errors
Message-ID: <20040416184516.GV4773@peach.ece.utexas.edu>
References: <20040415231659.GG4773@peach.ece.utexas.edu> <20040416124423.1858C3A404F@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040416124423.1858C3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 16, 2004 at 08:44:22AM -0400, Ed Street wrote:
> Are you planning on sharing the info you collect on this list?
I'll interpret that as a request. Yes, we will post a URL pointing to
our semester report when it is finished.

> Will you be testing it with execshield and pax?
No and no.
We are most interested in how single-bit errors affect security software
in general, rather than the protection of some specific software. If
we continue the project beyond this semester (likely if initial results
offer some hope) we may branch out to look at more than basic SELinux.

> A more realistic approach would be to run it as user_r:user_t because
> in the real world that's where your penetrations will likely happen
> at.
True. We can change the current role but as far as I know the difference
between user_r:user_t and sysadm_r:sysadm_t is only a bit offset so any
given fault is equally likely to affect their restrictions. Note that
for now we are only testing SELinux's ability to restrict one specific
access.

> If a file is 'protected' then why is it 777?
Because we want to measure SELinux's robustness when faced with
faults.


Thank you for your comments Ed,
Tom


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of tdbrown@uiuc.edu
> Sent: Thursday, April 15, 2004 7:17 PM
> To: SELinux@tycho.nsa.gov
> Cc: Michael Ihde
> Subject: SELinux security in the face of single bit errors
> 
> I'm taking a graduate level Fault Tolerant Computing course.  My partner 
> and I intend on injecting single bit faults into the data and text 
> sections of SELinux to see if such faults can compromise system 
> security. While it is obvious that a single bit error in some 
> structures, such as the AVC allowed field or the selinux_enforcing, can 
> open an SELinux system for a period of time.  We want to look for less 
> obvious holes which may be realized by a single bit flip (also called 
> soft-errors). Our plan is to run a User-mode SELinux kernel and use the 
> ptrace interface to inject errors in the SELinux text section and/or 
> data section. The kernel will execute a test program as init which will 
> attempt to violate the SELinux policy by writing to a protected file 
> with mod=777 and then shutdown the system.  Given more time we would 
> like to violate other  things than simple file permissions.
> 
> We are aware that the impact of a transient single bit errors depends on 
> how long the bit-error lasts.  In the case of an bit error in the AVC it 
> may only last a short time (when the avc entry is overwritten) or a long 
> time.  Bit errors in the text segment may last longer depending on the 
> particulars of the OS. We are not planning to measure the time that a 
> particular bits creates a vulnerability, we have limited time to get 
> results and the parameter is heavily dependant on the enviroment.  We
> will include this cavot in our report.
> 
> Our project was inspired by the following papers:
> 
>    * "An Experimental Study of Security Vulnerabilities Caused by 
> Errors"
>      Jun Xu, Shuo Chen, Abigniew Kalbarczyk, Ravishankar K. Iyer
> 
>    * "Using Memory Errors to Attack a Virtual Machine", Sudhakar
>      Govindavajhala, Andrew W. Appel
> 
>    * "Framework for Testing the Fault-Tolerance of Systems Including OS
>      and Network Aspects", Kerstin Buchacker, Volkmar Sieh (HASE '01)
> 
> If you have any comments or suggestions we would love to hear them.  To 
> save traffic on the mailing list you can add your comments to
>  
> http://www.randomwalking.com/cgi-bin/kwiki/index.cgi?ECE442OutsideComments
> 
> ~Michael Ihde & Tom Brown
> 
> 
> 
> ---
> 
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.656 / Virus Database: 421 - Release Date: 4/9/2004
>  
> 
> 
-- 
28 70 20 71 2C 65 29 61 9C B1 36 3D D4 69 CE 62 4A 22 8B 0E DC 3E
mailto:tdbrown@uiuc.edu
http://thecap.org/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
