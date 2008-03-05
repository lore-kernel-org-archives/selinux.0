Message-ID: <47CF1616.1010201@redhat.com>
Date: Wed, 05 Mar 2008 16:52:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ronald van den Blink <selinux@a61.nl>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Unreserved portnumbers in corenetwork
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>	 <1204730645.14217.39.camel@gorn>	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>	 <1204733123.14217.48.camel@gorn>	 <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>	 <1204735380.14217.60.camel@gorn>	 <6507AB86-A6D5-4314-BC06-86458D15C786@a61.nl> <47CF034E.2010407@redhat.com> <1204749406.1397.136.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204749406.1397.136.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2008-03-05 at 15:32 -0500, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Ronald van den Blink wrote:
>>> On Mar 5, 2008, at 5:43 PM, Christopher J. PeBenito wrote:
>>>
>>>> On Wed, 2008-03-05 at 17:16 +0100, Ronald van den Blink wrote:
>>>>> On Mar 5, 2008, at 5:05 PM, Christopher J. PeBenito wrote:
>>>>>
>>>>>> On Wed, 2008-03-05 at 16:47 +0100, selinux@a61.nl wrote:
>>>>>>>> Unfortunately there are 3 forces at work.  The first is that for the
>>>>>>>> most part, ports should always be labeled, because, for example,
>>>>>>>> port 80
>>>>>>>> is always going to be regarded as the http port.  The second is that
>>>>>>>> thats not always the case for non well-defined ports (your
>>>>>>>> situation).
>>>>>>>> The third is that portcons (the port labeling statements) only
>>>>>>>> work in
>>>>>>>> the base module.  So, though we want to make a happy medium
>>>>>>>> between the
>>>>>>>> first two, we can't overcome the final one within the constraints
>>>>>>>> of the
>>>>>>>> current toolchain.
>>>>>>>>
>>>>>>> Agree with that. But wouldn't the situation be a little less
>>>>>>> complicated
>>>>>>> if you decide not to define any ports above 1024 in the reference
>>>>>>> policy?
>>>>>> That breaks people that just want to use reference policy.
>>>>>>
>>>>> Does this mean that any module in the refpol that needs (for instance)
>>>>> port 8080 but isn't a http-cache-daemon uses corenetwork_httpd_cache
>>>>> and get's all the other ports defined there as well? Isn't that
>>>>> breaking the least priviliges idea? Because you're opening up more
>>>>> ports then needed?
>>>> It depends on how far you want/need to take least privilege.  By this
>>>> argument, having all of the shared libraries in /lib and /usr/lib being
>>>> the same label would be bad.  You have to evaluate the impact on your
>>>> security goals.
>>>>
>>> Well, that's exactly the reason why we choose not to label the libraries
>>> in /opt/jboss/lib (or whatever the exact place is) lib_t but
>>> jboss_lib_t, we don't want those lib's to be shared. In our view it is a
>>> security risk to declare a range of (unprivileged) ports as (in our
>>> case) http_cache and use them for just one of the ports ;) But, that's
>>> just one of the reasons. We are still wondering if it is a good approach
>>> to stop declaring ports > 1024 in corenetwork and make a generic handler
>>> so modules can create ports > 1024 on the fly if needed.
>>>
>>>
>>>
>>>> -- 
>>>> Chris PeBenito
>>>> Tresys Technology, LLC
>>>> (410) 290-1411 x150
>>>>
>>>>
>>>> -- 
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to
>>>> majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>> I like Stephen suggestion of removing corenetwork ports altogether is
>> defining them via semanage.  This would allow flexibility where a user
>> wants to allow apache to listen on a special port but not port 80.
>>
>> Currently you can not remove a port that is defined in corenetwork.
>>
>> The problem with removing corenetwork and adding all the ports via
>> semanage would take a very long time with the current tool chain.
> 
> Should be a simple extension to semanage front end to take a set of port
> contexts and update them in a single libsemanage transaction.  Just like
> semodule lets you insert a set of modules together in a single
> transaction.
> 
Of course we have other problems.  How do you handle update?

Currently we just allow corenetwork to update all the ports.  But if we
move all the ports to semanage and out of the base policy, we have to
maintain the fact that a user removed port 8080 from http_port_t.

For example.

User installs SELinux rpm which includes a list of all defined ports.
semanage adds them.

A user decides he no longer wants to allow httpd_port_t to listen on
port 80.

semanage port -d 80

Later selinux policy is updated.

How do we stop the update procedure from re-adding port 80?

Another problem is we use the same types for both name_bind and
name_connect.

So if the user does not want to allow httpd_t to listen on port 80, and
we allow him to remove it, his confined firefox and squid will now not
be allowed to connect to port 80.




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfPFhYACgkQrlYvE4MpobN+8gCgwIY0FwsdPPvy9O6fyT7LCoMi
CgsAoIt19/8cljfVolMGIxj9p+Cg7nlv
=h3k/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
