Subject: Re: [ SEMANAGE ] Introduce record table
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, dwalsh@redhat.com,
   jbrindle@tresys.com
In-Reply-To: <43258D48.80702@cornell.edu>
References: <43256F48.7060909@cornell.edu>  <43258D48.80702@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:46:03 -0400
Message-Id: <1126712763.12299.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 10:14 -0400, Ivan Gyurdiev wrote:
> The attached patch applies on top of the other one.
> It introduces the record table as the first thing
> which will be stored in the database config (a database config
> stores parameters specific to a database (a.k.a. file))

Thanks, merged upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
