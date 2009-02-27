Message-ID: <49A76BD5.7040902@ak.jp.nec.com>
Date: Fri, 27 Feb 2009 13:28:05 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain> <49A74850.9070704@ak.jp.nec.com>
In-Reply-To: <49A74850.9070704@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
>> selinux_getcon() says that it returns false on error.  So false is a
>> legal string value in PHP?  And you don't mean the string "false", I
>> presume?  So it can be used in a conditional with the expected effect?
> 
> I belive we can discriminate between a legal string value and a bool one.
> This function is available to check either one is returned.
>   http://jp.php.net/manual/en/function.is-string.php
> 
> However, it is necessary to note that "false" is casted to empty string
> when we compare them without special care, like:
> 
>   $ php -r 'if ("" == false)
>                 echo "hello!\n";'
>   hello!
> 
> I'll confirm PHP developers whether we can consider "false" can be
> an error condition on functions which return string, or not.

I was suggested to use "===" operator in the PHP list.
It requires both of left and right side have same type and value,
so we can discriminate between legal strings (including empty one)
and error status.

  http://jp.php.net/manual/en/language.operators.comparison.php

>> security classes can be unsigned integers or their own type.
>> access vectors can be unsigned integers, bitfields, or their own type.
>> Or we could only deal with security classes and access vectors as
>> strings and lists of strings respectively for PHP, and map them back and
>> forth to integers within the wrappers.
> 
> I think it is good idea.
> 
> You are saying such an interface, aren't you?
> 
>   selinux_compute_av("staff_t:staff_r:staff_t",
>                      "system_u:object_r:shadow_t",
>                      "file");
>   It returns an associative array which contains three subarray
>   named as "allowed", "auditallow", "auditdeny".

I tried to implement the revised one.

We can check its result like:
  $avd = selinux_compute_av(...);
  $allowed = $avd["allowed"];
  if ($allowed["read"] && $allowed["getattr"])
      echo "Readable!\n";

------
$ php -r '$scontext = "staff_u:staff_r:staff_t";
          $tcontext="system_u:object_r:etc_t";
          $avd = selinux_compute_av($scontext, $tcontext, "file");
          var_dump($avd["allowed"]);'
array(21) {
  ["ioctl"]=>
  bool(true)
  ["read"]=>
  bool(true)
  ["write"]=>
  bool(false)
  ["create"]=>
  bool(false)
  ["getattr"]=>
  bool(true)
  ["setattr"]=>
  bool(false)
  ["lock"]=>
  bool(true)
  ["relabelfrom"]=>
  bool(false)
  ["relabelto"]=>
  bool(false)
  ["append"]=>
  bool(false)
  ["unlink"]=>
  bool(false)
  ["link"]=>
  bool(false)
  ["rename"]=>
  bool(false)
  ["execute"]=>
  bool(true)
  ["swapon"]=>
  bool(false)
  ["quotaon"]=>
  bool(false)
  ["mounton"]=>
  bool(false)
  ["execute_no_trans"]=>
  bool(true)
  ["entrypoint"]=>
  bool(false)
  ["execmod"]=>
  bool(false)
  ["open"]=>
  bool(false)
}

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
