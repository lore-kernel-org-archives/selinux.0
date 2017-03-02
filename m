Subject: Re: selinux transition rules
References: <81aa96e5-873c-2514-92b2-2d272b8fe619@rm-it.pl>
 <CAJ2a_DdR_k-CPheK0bU7RbZLM_TBmdAuJszvsod8sqkfCJL9Pg@mail.gmail.com>
 <CAJ2a_DdWM7KYCAecAAf-jnt9zPsgmCumUx=HXODDR699WQAY3A@mail.gmail.com>
 <CAJ2a_DcUpbJLicXRubg5Whs43Y_1WuxBaZks30javMuh+v2bcw@mail.gmail.com>
 <6b788f35-ffea-4fee-faba-3a4cb7061608@rm-it.pl>
From: "RM-IT R.Mielnik" <r.mielnik@rm-it.pl>
To: Selinux@tycho.nsa.gov
Message-ID: <9f2d3707-64bf-5fca-8f09-cdbe9006398f@rm-it.pl>
Date: Thu, 2 Mar 2017 12:18:19 +0100
MIME-Version: 1.0
In-Reply-To: <6b788f35-ffea-4fee-faba-3a4cb7061608@rm-it.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


W dniu 01.03.2017 o 00:51, RM-IT R.Mielnik pisze:
>
>>             hi,
>>
>>        i got a problem with transition rules. what i try to do is to
>>     make selinux change the context type of "rwdirectory" while it is
>>     created via ftp (proftpd in ftpd_t domain) in httpd_user_content_t
>>     directory
[...]

ok, i've found the reason. using auditctl mentioned in "SELinux type 
transition rule not working" (jason zaman: thank you:)) i got on working 
system:

type=PATH msg=audit(1488452722.762:8109253): item=0 name="/some/path/" 
inode=403256560 dev=93:00 mode=040755 ouid=48 ogid=48 rdev=00:00 
obj=system_u:object_r:httpd_user_content_t:s0 objtype=PARENT

type=PATH msg=audit(1488452722.762:8109253): item=1 
name="/some/path/.rw" inode=1386632 dev=93:00 mode=040755 ouid=48 
ogid=48 rdev=00:00 obj=system_u:object_r:httpd_user_rw_content_t:s0 
objtype=CREATE

and on failing system(s):

type=PATH msg=audit(1488450181.426:89307): item=0 name="/some/path/" 
inode=134671193 dev=fd:02 mode=040755 ouid=48 ogid=48 rdev=00:00 
obj=system_u:object_r:httpd_user_content_t:s0 objtype=PARENT

type=PATH msg=audit(1488450181.426:89307): item=1 name="/some/path/" 
inode=134671193 dev=fd:02 mode=040755 ouid=48 ogid=48 rdev=00:00 
obj=system_u:object_r:httpd_user_content_t:s0 objtype=PARENT

type=PATH msg=audit(1488450181.426:89307): item=2 
name="/some/path/.dstXX6M4cr8" inode=101891 dev=fd:02 mode=040755 
ouid=48 ogid=48 rdev=00:00 obj=system_u:object_r:httpd_user_content_t:s0 
objtype=DELETE

type=PATH msg=audit(1488450181.426:89307): item=3 name="/some/path/.rw" 
inode=101891 dev=fd:02 mode=040755 ouid=48 ogid=48 rdev=00:00 
obj=system_u:object_r:httpd_user_content_t:s0 objtype=CREATE

on a second case proftpd uses temporary dir name, so there is no chance 
for pattern to work. bummer... have to work it out differently
