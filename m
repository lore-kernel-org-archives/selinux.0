Subject: Re: attribute definitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <3F2FD7E9.6010207@diyab.net>
References: <3F2FD7E9.6010207@diyab.net>
Content-Type: text/plain
Message-Id: <1060107980.3770.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 05 Aug 2003 14:26:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-08-05 at 12:14, Diyab wrote:
> Where are the type attributes defined?  I'm trying to find out what 
> these attributes give permissions to but I can not find any reference to 
> where they are defined.  I've tried grepping the policy for things like 
> sysadmfile but all I can find is the use of the attribute, not a definition.

The type attribute names are declared (by convention only) in
policy/attrib.te, with comments describing their intended purpose. 
Originally, type attribute names were implicitly declared when they were
used in a type declaration, but explicit declarations were later added
and made mandatory to safeguard against errors in type declarations and
to provide a centralized place for reviewing the set of existing
attributes and their intended purpose. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
