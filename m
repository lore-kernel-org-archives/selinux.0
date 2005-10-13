Message-ID: <434EE146.3010804@tresys.com>
Date: Thu, 13 Oct 2005 18:35:50 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>	<1129035115.3308.67.camel@moss-spartans.epoch.ncsc.mil> <1129231767.13490.31.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129231767.13490.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-10-11 at 08:51 -0400, Stephen Smalley wrote:
> 
>>Any thoughts on the above question?  If we leave it publically defined,
>>then users can still directly allocate/free sepol_module_package's
>>rather than using the provided create/free interfaces and can directly
>>access the policy, file_contexts, and file_context_len fields.  Do we
>>anticipate sepol_module_package's including other information in the
>>future?
>>
>>Also, I wanted to note that when I introduced create/free interfaces for
>>sepol_module_package, I had to rename the existing interface named
>>"sepol_module_package_create" to "sepol_module_package_create_file".
>>That interface was for creating a package file from a policy file and a
>>file contexts file, not for creating the struct itself.
> 
> 
> Patch below hides the sepol_module_package type definition within
> libsepol, committed to cvs.
> 
> We still need to decide what to do about the
> sepol_module_package_create_file interface to make it extensible; one
> option is to discard it and require the caller to build up a
> sepol_module_package struct via a create/set_xx/set_yy sequence and then
> use the write interface to write the final package file.  It appears the
> we would only need/want a set_file_contexts interface at present, as the
> policydb is allocated by the create interface and can be extracted via
> get and then populated using the other policydb interfaces (read,
> expand_module, etc).  The only user of the create_file interface
> presently is semodule_package.
> 
> Also need to deal with the package file format itself, i.e. versioning,
> sections, etc. per the discussion on fedora-selinux-list.
> 
It also seems like the current CLI for semanage_package is insufficient. 
If we are building support into the format and API for sections and 
other data the semanage_package options should reflect what sections are 
you are filling in with what data, something like

-f file_contexts
-m module data

and anything else added later would obviously get an argument.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
