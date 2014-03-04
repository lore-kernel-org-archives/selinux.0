Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s241bfMe001586
 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2014 20:37:41 -0500
Message-ID: <1393897055.79488.YahooMailNeo@web124904.mail.ne1.yahoo.com>
Date: Mon, 3 Mar 2014 17:37:35 -0800 (PST)
From: Andy Ruch <adruch2002@yahoo.com>
Subject: sshd and setcurrent
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,


I'm implementing a custom SELinux policy based on the reference policy for a secure RHEL 6.5 system. Currently, my policy does not allow 'setcurrent' for sshd_t and I'm seeing the appropriate AVCs associated to this. However, even with these AVCs, everything appears to work. I still end up with a bash process running as staff_t. The only difference I see using 'ps -efZ' is the context of parent process of the bash shell:

PERMISSIVE:

system_u:system_r:sshd_t:s0-s0:c0.c1023    root    29470    1520     ...    sshd: myuser [priv]
myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser  29475    29470    ...    sshd: myuser@pts/0
myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser  29476    29475    ...    -bash



ENFORCING (context on 2nd line different):

system_u:system_r:sshd_t:s0-s0:c0.c1023    root    29505    1520     ...    sshd: myuser [priv]
system_u:system_r:sshd_t:s0-s0:c0.c1023    myuser  29510    29505    ...    sshd: myuser@pts/0
myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser  29511    29510    ...    -bash


Does this second process labeled as "sshd_t" provide any usability or security issues?


Digging into the policy code more, I see comments in domain.te along the lines of "setcurrent breaks process tranquility" and "don't use it if you don't understand it". Could someone provide some more details regarding when to use 'setcurrent' for a secure system? 


Also, I understand that the RHEL Targeted policy has a completely different use case than my custom policy. However, why is it allowed in the Targeted policy if the sshd appears to work without it?


Thanks,
Andy Ruch
