Subject: Re: Indirect access to type
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F2644C21E9B06171BFE5147AF180@phx.gbl>
References: <BAY114-F2644C21E9B06171BFE5147AF180@phx.gbl>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 09:56:14 -0400
Message-Id: <1159538174.8496.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 15:13 +0200, Salvo Giuffrida wrote:
> In the book "SELinux by example", at paragraph 14.4.2, the author talks 
> about indirect access to types, which is possible to look for using apol 
> (checking the option "Include indirect matches" when you search for TE 
> rules). I don't understand the meaning of this...How could a domain gain 
> access to a type it is not authorized for? Using domain transitions?

See the help text for apol.  As described there:
"The "Include Indirect Match" checkbox alters the meaning of the search
if a type is used in the given field (this option is not available if an
attribute is used). In this case, the search will find rules that have
either the provided type or any of the type's attributes in the
appropriate field."

Example:  
If your policy has the rule:
	allow domain self:process fork;
Then a search with source type "httpd_t" without indirect matches
enabled will not show the above rule, since "httpd_t" is not explicitly
listed.  But if you enable indirect matches, the above rule will be
listed since "domain" is a type attribute that expands to all types with
that attribute, and this includes "httpd_t".

That is still limited to direct relationships between type pairs.  If
you want to consider domain transitions and/or information flow, then
the Analysis tab is what you want.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
