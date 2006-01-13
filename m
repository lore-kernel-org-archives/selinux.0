Message-ID: <43C82889.7020901@cornell.edu>
Date: Fri, 13 Jan 2006 15:24:09 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE(lib/tool)] Remove add_local/set_local
References: <43C2C414.9070503@cornell.edu> <1137160220.3445.116.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137160220.3445.116.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-01-09 at 13:14 -0700, Ivan Gyurdiev wrote:
>   
>> Hi, this patch removes add_local and set_local functions from the dbase 
>> API, since they duplicate other functionality.
>>     
>
> Merged as of libsemanage 1.5.12 and policycoreutils 1.29.6.
> I then later had to move the semanage tool diffs over to the new
> seobject.py introduced by Dan in a later policycoreutils.
>   
Steven, will you be increasing the major number with the next official 
release? Some of the changes made are suspect API changes (size_t 
conversion in sepol/semanage, commit numbers in semanage, compare 
behavior in sepol/semanage), and this one is a clear change... What 
about sepol?

If the number will be increased, I'll change some other not-so-smart 
APIs, like port_get_proto_str, and fcontext_get_proto_str, which should 
take an integer, and return a string, instead of taking a port or 
context. We could also deprecate some things in sepol, or add more 
handles here and there.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
