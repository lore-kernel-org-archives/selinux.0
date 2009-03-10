Message-ID: <49B6114C.8040704@ak.jp.nec.com>
Date: Tue, 10 Mar 2009 16:05:48 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain> <49A6ADE2.8040602@redhat.com> <06A6610D4F464D4EBEAFBF2C5F86911EE74492@exchange2.columbia.tresys.com> <49A74EB1.80508@ak.jp.nec.com> <49A83A41.50601@redhat.com> <49ACA5FE.8000804@ak.jp.nec.com>
In-Reply-To: <49ACA5FE.8000804@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

http://koji.fedoraproject.org/koji/packageinfo?packageID=7917

Now the "php-pecl-selinux" package got approved in Fedora Project.
Some days later, it will be delivered to mirrors.

KaiGai Kohei wrote:
 > Now it in PECL repository:
 >   http://pecl.php.net/package/selinux
 >   http://cvs.php.net/viewvc.cgi/pecl/selinux/

BTW, I still mark its state as "devel". It means we have a possibility
to change APIs. If you found anything to be improved, please tell me.


The following example is just a toy, which implements
Paul's "getpeercon_server.c" example in PHP.
--------------
#!/usr/bin/php -q
<?
if (count($argv) < 2) {
     echo "usage: ".$argv[0]." <port>\n";
     return 1;
}

$conn_url = sprintf("tcp://0.0.0.0:%u", $argv[1]);
$server = stream_socket_server($conn_url, $errno, $errmsg);
if (!$server) {
     echo "error: $errmsg ($errno)\n";
     return 1;
}

while (($client = stream_socket_accept($server))) {
     $ipaddr = stream_socket_get_name($client, true);
     $peercon = selinux_getpeercon($client);
     printf("connect %s => %s\n", $ipaddr, !$peercon ? "null" : $peercon);
     fclose($client);
}
fclose($server);
?>
--------------

   [kaigai@saba ~]$ ./peersock.php 1234
   connect 10.19.71.82:4643 => user_u:user_r:user_t:s0
   connect 127.0.0.1:36277 => staff_u:staff_r:staff_t:s0
   connect 10.19.71.81:48902 => null

I guess it also can be used for education purpose because it enables
to observe the behavior of SELinux with quick try-and-error steps. :-)

Thanks,

> It is necessary the package to be reviewed whether the specfile
> correctly follows Fedora packaging guideline [1] [2], or not.
> I would like folks to help reviewing it.
> 
> In addition, Fedora Project requires all the new packages
> to be approved by core maintainers called as "sponsor" [3].
> 
> Could you introduce me an appropriate person to recommend
> the package?
> 
> Thanks,
> 
> [1] http://fedoraproject.org/wiki/Packaging/Guidelines
> [2] http://fedoraproject.org/wiki/Packaging/PHP
> [3] 
> https://admin.fedoraproject.org/accounts/group/members/packager/*/sponsor
> 
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> KaiGai Kohei wrote:
>>> Joshua Brindle wrote:
>>>>> -----Original Message-----
>>>>> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>>>>>
>>>>> I would rather package this up as part of libselinux, perhaps
>>>>> libselinux-php, rather then make a new package.
>>>> The last time I used PHP (admittedly years ago) most if not all 
>>>> bindings
>>>> were included in the upstream PHP distribution.
>>> At least, most of PHP extensions has php-* naming convension, like:
>>>   php-mysql, php-mbstring, php-ldap, ...
>>>
>>> Most of major extensions are distributed as subpackages of php itself,
>>> but some of extensions are not distributed as separated package.
>>> (Please find php-* on the list of Fedora SRPMs.)
>>>
>>> I don't think we need to wait for it get merged into the core PHP,
>>> to release php-selinux package.
>>>
>>> Thanks,
>> Ok then fine leave it as a separate package.
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
