Message-ID: <49A74850.9070704@ak.jp.nec.com>
Date: Fri, 27 Feb 2009 10:56:32 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain>
In-Reply-To: <1235659159.13059.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2009-02-26 at 15:22 +0900, KaiGai Kohei wrote:
>> Hi,
>>
>> I tried to implement a libselinux wrapper for PHP script language
>> several months ago.
>>
>> Now, I have a plan to propose the facility into official extensions
>> of PHP community, called as PECL (PHP Extension Community Library),
>> and Fedora project.
>>
>> Before that, I would like folks to check the list of supported APIs.
>>
>> * The list of APIs : PHP/SELinux binding
>>   http://code.google.com/p/sepgsql/wiki/Memo_PHP_SELinux
> 
> Sorry for not looking at this previously.  Userspace folks, please take
> a look before we are locked into an API for PHP scripts.
> 
> I have no knowledge of PHP, so with that in mind:
> 
> I take it that php doesn't namespace the functions by module name,
> unlike python?  And thus you felt the need to change the names of the
> functions to use a selinux_ prefix?

This article recommends any function names are prefixed by module name.

 * PHP Extension Writing
   http://talks.somabo.de/#20071012
   http://talks.somabo.de/200710_extension_writing.pdf
   - Please see the page 27 (PHP Functions).

> selinux_is_enabled() aka is_selinux_enabled() can also return < 0 if
> there is an error when trying to determine whether SELinux is in fact
> enabled.  So it either needs an int return value or you could have your
> php wrapper test for that case internally and return false.  Most C code
> is using is_selinux_enabled() > 0 as the test for selinux-enabled.

Oops, the current implementation can return 'true' on an error state.
I'll fix it.

> selinux_getcon() says that it returns false on error.  So false is a
> legal string value in PHP?  And you don't mean the string "false", I
> presume?  So it can be used in a conditional with the expected effect?

I belive we can discriminate between a legal string value and a bool one.
This function is available to check either one is returned.
  http://jp.php.net/manual/en/function.is-string.php

However, it is necessary to note that "false" is casted to empty string
when we compare them without special care, like:

  $ php -r 'if ("" == false)
                echo "hello!\n";'
  hello!

I'll confirm PHP developers whether we can consider "false" can be
an error condition on functions which return string, or not.

> selinux_getpidcon() takes an int pid in your interface vs pid_t in
> libselinux.  Is there no type defined for process identifiers in PHP?

PHP does not have special purpose type.
It seems to me they don't care about it.
  http://jp.php.net/manual/en/function.posix-getpid.php
  http://jp.php.net/manual/en/function.posix-kill.php

> security classes can be unsigned integers or their own type.
> access vectors can be unsigned integers, bitfields, or their own type.
> Or we could only deal with security classes and access vectors as
> strings and lists of strings respectively for PHP, and map them back and
> forth to integers within the wrappers.

I think it is good idea.

You are saying such an interface, aren't you?

  selinux_compute_av("staff_t:staff_r:staff_t",
                     "system_u:object_r:shadow_t",
                     "file");
  It returns an associative array which contains three subarray
  named as "allowed", "auditallow", "auditdeny".

> matchpathcon is being deprecated in favor of the selabel* interfaces.

OK, I'll consider to rewrite it using these interfaces.

Thanks,

>>   NOTE:
>>    - All the "_raw" interfaces are omitted, because we can translate
>>      a human readable format into a system one later using
>>        string selinux_trans_to_raw_context(string $context).
>>    - All the AVC related interfaces are omitted, because I didn't
>>      assume PHP script works as a userspace object manager.
>>
>> * Step to build and installation
>>   % svn checkout http://sepgsql.googlecode.com/svn/misc/php-selinux
>>   % cd php-selinux
>>   % ./build-php-selinux.sh
>>          :
>>   Wrote: /home/kaigai/RPMS/SRPMS/php-selinux-0.1626-beta.fc10.src.rpm
>>   Wrote: /home/kaigai/RPMS/RPMS/i386/php-selinux-0.1626-beta.fc10.i386.rpm
>>          :
>>   % su
>>   # rpm -Uvh /path/to/package/php-selinux-0.1626-beta.fc10.i386.rpm
>>
>>   NOTE:
>>    - It requires "php-devel" and "libselinux-devel" are installed
>>      prior to ./build-php-selinux.sh
>>    - It requires "rpmbuild" works correctly. Please confirm your
>>      ~/.rpmmacros, if the script does not work correctly.
>>
>> * Example:
>>   % rpm -q php-selinux
>>   php-selinux-0.1626-beta.fc10.i386
>>   % php -r 'echo selinux_getcon()."\n";'
>>   unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemMiddle
>>   % php -r 'echo selinux_getfilecon("/etc/shadow")."\n";'
>>   system_u:object_r:shadow_t
>>   % php -r '$tclass = selinux_string_to_class("file");
>>             $avd = selinux_compute_av("staff_u:staff_r:staff_t:s0",
>>                                       "system_u:object_r:etc_t:s0",
>>                                       $tclass);
>>             var_dump($avd);'
>>   array(5) {
>>     ["allowed"]=>
>>     int(139347)
>>     ["decided"]=>
>>     int(-1)
>>     ["auditallow"]=>
>>     int(0)
>>     ["auditdeny"]=>
>>     int(-17)
>>     ["seqno"]=>
>>     int(41)
>>   }
>>
>> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
