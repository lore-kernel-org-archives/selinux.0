Message-ID: <52A0E2CE.2080304@tycho.nsa.gov>
Date: Thu, 05 Dec 2013 15:32:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Information flow paths over devtty_t
References: <1386273455.65331.YahooMailNeo@web163402.mail.gq1.yahoo.com>
In-Reply-To: <1386273455.65331.YahooMailNeo@web163402.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/05/2013 02:57 PM, Andy Ruch wrote:
> I'm implementing a strict SELinux policy based on the reference policy using RHEL 6.3. Using 'apol' to analyze my information flow paths, I've been able to eliminate most of the tty/console paths. However, I can't seem to find a way to eliminate the access to the controlling terminal devtty_t. 
> 
> 
> I see that this is allowed in domain.te:
> 
> # Use trusted objects in /dev
> dev_rw_null(domain)
> dev_rw_zero(domain)
> term_use_controlling_term(domain)
> 
> 
> Is devtty_t something I should be concerned about? Is this a type that can be used to share information between processes or is it special like /dev/null and /dev/zero?

It is special; it represents the controlling terminal for the current
process.

Whether or not it could be an issue likely depends on whether you
support newrole -l or any other way of changing levels while preserving
the same controlling tty.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
