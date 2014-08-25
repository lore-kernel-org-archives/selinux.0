From: "Stepan G. Fedorov" <stfedorov@gmail.com>
Message-ID: <53FB19C7.1040500@gmail.com>
Date: Mon, 25 Aug 2014 15:11:03 +0400
MIME-Version: 1.0
To: Selinux@tycho.nsa.gov
Subject: semanage interface has no effect
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello!

Goal of this experiment is to see allow rules for netif class objects is 
working.

I use debian wheezy whith MLS selinux policy, in enforced mode.

eth0 is hte only netwotk interface, except lo.

sesearch --allow -cnetif shows lots of allow rules for netif_t target 
type / netif target class.

I do:
  1) I add new type nginx_http_if_t with my own policy module;
  2) semanage interface -a -t nginx_http_if_t -r s1:c0.c1023 eth0.

I expect: to see all the processes in system unable to read/write 
packets from eth0 interface.

I actually got: nothing changes - all networking is working as it was 
before changing of interface context.


What am I doing/understanding wrong?

Thank you!

-- 
Stepan G. Fedorov <StFedorov@gmail.com>
Tel: +7-965-750-91-91
