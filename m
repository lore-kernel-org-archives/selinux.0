Message-ID: <43CEAF5E.5020503@tresys.com>
Date: Wed, 18 Jan 2006 16:13:02 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Seusers vs ldap
References: <43CE880B.3020908@cornell.edu> <43CE8AD6.7050109@redhat.com>
In-Reply-To: <43CE8AD6.7050109@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Ivan Gyurdiev wrote:
> 
>> How would we go about implementing LDAP support for seusers in 
>> libsemanage?
>> I asked Joshua about this on IRC, but I think we to plan this on list.
>>
>> I think the most important question to be decided is whether we'll use 
>> libldap directly, or execute external programs to work with LDAP? The 
>> first option makes libsemanage always linked to libldap.
> 
> Why not loadable module?
> 
it's a possibility. there is no kind of dynamic library loading 
infrastructure in libsemanage though, and we should really figure out 
which is the best way to do it before proceeding on any of these routes.

>>
>> I also don't quite understand the role of the system-wide default 
>> properties in ldap.conf. Joshua is telling me we'll need a server, 
>> context, and keys specific to semanage (so we have to write all 
>> ldap-related things in semanage.conf), but I'm not sure why the 
>> context and server can't be shared with ldap.conf if necessary - I'm 
>> probably still not understanding how this works - I have very limited 
>> knowledge of ldap at this point. If you open up system-config-auth on 
>> fedora, they seem to share the LDAP config for authentication and user 
>> info, if you enable both of them.

the ldap.conf could tell the system authentication server and search 
context, sure. semanage.conf needs a minimal amount of configuration to 
tell libsemanage where to look for each of its components though. Also, 
the libsemanage LDAP backend will need to know how to search for users, 
different directory servers use different keys for user entries, etc.

>>
>> Also, do we have to write a schema? Does that schema get added to the 
>> slapd package?
> 
The schema is installed when the app that uses the schema is installed 
(at least this is how it worked when I used eDirectory). Prepackaging 
them with the directory server makes it inconvenient for us to keep them 
up to date.

> 
> We want support for Fedora-Directory also.
> 

LDAP will support fedora directory server just fine, as well as all 
other modern directory server implementations.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
