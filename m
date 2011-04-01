Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p31H9LIa021052
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 13:09:21 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p31H9JxF005484
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 17:09:20 GMT
Message-ID: <4D9606BD.20009@redhat.com>
Date: Fri, 01 Apr 2011 13:09:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Bill Chimiak <wch1m1@gmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: fwknop, fwknopd,  fwknop_serv
References: <201104011210.36367.w.chimiak@ieee.org> <4D95FEDF.9010907@gmail.com>
In-Reply-To: <4D95FEDF.9010907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/01/2011 12:35 PM, Dominick Grift wrote:
> On 04/01/2011 06:10 PM, Bill Chimiak wrote:
>> fwknop is a single passphrase authorization system.
>> Fairly cool.  selinux did not like fwknop out of the box.
>> It wanted a new module:
> 
>> module iptab2log 1.0;
> 
>> require {
>>         type var_log_t;
>>         type iptables_t;
>>         class file write;
>> }
> 
>> #============= iptables_t ==============
>> allow iptables_t var_log_t:file write;
> 
> Did you notice any loss of functionality?
> 
> This may be a leaked file descriptor or something may be passing the
> open file to iptables.
> 
> You may be able to dontaudited this:
> 
> dontaudit iptables_t var_log_t:file write;
> 
> Which file exactly is it trying to write to?
> 
> By the way this is not the optimal list to be posting this to.
> 
>> It works now.  Was there another way to do this?
>> William J. Chimiak
>> Laboratory for Telecommunication Sciences 
>> 8080 Greenmead Drive,  College Park, MD 20740
>> 301-422-5217
> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> 

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



Most likely a redirection of stdout.

script > /var/log/my.log

Would cause this type of AVC for any confined app being run within the
script.

A hacky way to get out of it without changing policy, would be to execute
script | cat > /var/log/my.log

Another option would be to set it up from append

script >> /var/log/my.log

Which would only require append privs.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2WBr0ACgkQrlYvE4MpobO1HQCfac3GdEWkNtvRP2PeXQqXftVC
jqgAnR9Sd4iIj7/WoLoZULPUwo6pXhWJ
=FTQ8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
