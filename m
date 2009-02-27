Message-ID: <49A74B8A.4050106@ak.jp.nec.com>
Date: Fri, 27 Feb 2009 11:10:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain> <49A6ADE2.8040602@redhat.com>
In-Reply-To: <49A6ADE2.8040602@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
>> On Thu, 2009-02-26 at 15:22 +0900, KaiGai Kohei wrote:
>>> Hi,
>>>
>>> I tried to implement a libselinux wrapper for PHP script language
>>> several months ago.
>>>
>>> Now, I have a plan to propose the facility into official extensions
>>> of PHP community, called as PECL (PHP Extension Community Library),
>>> and Fedora project.
>>>
>>> Before that, I would like folks to check the list of supported APIs.
>>>
>>> * The list of APIs : PHP/SELinux binding
>>>   http://code.google.com/p/sepgsql/wiki/Memo_PHP_SELinux
>> Sorry for not looking at this previously.  Userspace folks, please take
>> a look before we are locked into an API for PHP scripts.
>>
>> I have no knowledge of PHP, so with that in mind:
>>
>> I take it that php doesn't namespace the functions by module name,
>> unlike python?  And thus you felt the need to change the names of the
>> functions to use a selinux_ prefix?
>>
>> selinux_is_enabled() aka is_selinux_enabled() can also return < 0 if
>> there is an error when trying to determine whether SELinux is in fact
>> enabled.  So it either needs an int return value or you could have your
>> php wrapper test for that case internally and return false.  Most C code
>> is using is_selinux_enabled() > 0 as the test for selinux-enabled.
>>
>> selinux_getcon() says that it returns false on error.  So false is a
>> legal string value in PHP?  And you don't mean the string "false", I
>> presume?  So it can be used in a conditional with the expected effect?
>>
>> selinux_getpidcon() takes an int pid in your interface vs pid_t in
>> libselinux.  Is there no type defined for process identifiers in PHP?
>>
>> security classes can be unsigned integers or their own type.
>> access vectors can be unsigned integers, bitfields, or their own type.
>> Or we could only deal with security classes and access vectors as
>> strings and lists of strings respectively for PHP, and map them back and
>> forth to integers within the wrappers.
>>
>> matchpathcon is being deprecated in favor of the selabel* interfaces.
>>
>>>   NOTE:
>>>    - All the "_raw" interfaces are omitted, because we can translate
>>>      a human readable format into a system one later using
>>>        string selinux_trans_to_raw_context(string $context).
>>>    - All the AVC related interfaces are omitted, because I didn't
>>>      assume PHP script works as a userspace object manager.
>>>
>>> * Step to build and installation
>>>   % svn checkout http://sepgsql.googlecode.com/svn/misc/php-selinux
>>>   % cd php-selinux
>>>   % ./build-php-selinux.sh
>>>          :
>>>   Wrote: /home/kaigai/RPMS/SRPMS/php-selinux-0.1626-beta.fc10.src.rpm
>>>   Wrote: /home/kaigai/RPMS/RPMS/i386/php-selinux-0.1626-beta.fc10.i386.rpm
>>>          :
>>>   % su
>>>   # rpm -Uvh /path/to/package/php-selinux-0.1626-beta.fc10.i386.rpm
>>>
>>>   NOTE:
>>>    - It requires "php-devel" and "libselinux-devel" are installed
>>>      prior to ./build-php-selinux.sh
>>>    - It requires "rpmbuild" works correctly. Please confirm your
>>>      ~/.rpmmacros, if the script does not work correctly.
>>>
>>> * Example:
>>>   % rpm -q php-selinux
>>>   php-selinux-0.1626-beta.fc10.i386
>>>   % php -r 'echo selinux_getcon()."\n";'
>>>   unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemMiddle
>>>   % php -r 'echo selinux_getfilecon("/etc/shadow")."\n";'
>>>   system_u:object_r:shadow_t
>>>   % php -r '$tclass = selinux_string_to_class("file");
>>>             $avd = selinux_compute_av("staff_u:staff_r:staff_t:s0",
>>>                                       "system_u:object_r:etc_t:s0",
>>>                                       $tclass);
>>>             var_dump($avd);'
>>>   array(5) {
>>>     ["allowed"]=>
>>>     int(139347)
>>>     ["decided"]=>
>>>     int(-1)
>>>     ["auditallow"]=>
>>>     int(0)
>>>     ["auditdeny"]=>
>>>     int(-17)
>>>     ["seqno"]=>
>>>     int(41)
>>>   }
>>>
>>> Thanks,
> I would rather package this up as part of libselinux, perhaps
> libselinux-php, rather then make a new package.
> 
> I have had requests for a libsemanage-ruby if anyone wants to delve into it.

Is it possible to pack two modules with different licenses into one
package? Any PELC modules are required to be licensed by PHP license.

It is considered as LGPL compatible, but I'm not a lawyer.
   http://www.php.net/license/3_01.txt

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
