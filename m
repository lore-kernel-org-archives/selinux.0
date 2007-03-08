Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Joshua Brindle <jbrindle@tresys.com>, casey@schaufler-ca.com,
        russell@coker.com.au, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <45F00BA8.6090107@kaigai.gr.jp>
References: <989281.84407.qm@web36612.mail.mud.yahoo.com>
	 <45EEE1C1.4070804@tresys.com>  <45F00BA8.6090107@kaigai.gr.jp>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 08:25:42 -0500
Message-Id: <1173360342.10467.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 22:12 +0900, KaiGai Kohei wrote:
> Joshua Brindle wrote:
> > Casey Schaufler wrote:
> >> --- KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> >>
> >>  
> >>  
> >>> I think unique identification for all tuples are
> >>> difficult, because we can
> >>> create a table without Oid (object id) or primary
> >>> key to identify a tuple
> >>> from outside of the table...
> >>>
> >>> BTW, the string representations of security contexts
> >>> are stored in a separate
> >>> table named as 'pg_selinux', defined with Oid (which
> >>> have 4-byte length).
> >>> In SE-PostgreSQL, any tuples have Oid of pg_selinux
> >>> as a security context.
> >>> Thus, storage consumption is limited.
> >>>     
> >>
> >> How does this method compare to the schemes
> >> used in the Oracle evaluated MLS DBMS?
> >>
> >>   
> > IIRC Oracle basically has polyinstanciated tables (using views) to 
> > implement MLS, which gives far less granularity and doesn't allow for 
> > labeled rows or columns. KaiGai's work leverages all the security models 
> > SELinux can use to allow for flexible policies. The technical decision 
> > to use another table to store the oid of the context seems appropriate, 
> > since that is how rdbms's operate in general.
> 
> I think the biggest difference is whether RDBMS utilizes the security
> functionalities of operating system, or not.
> 
> For example, SE-PostgreSQL obtains the security context of the client via
> getpeercon(), and makes a decision with the security policy.
> It enables to ensure a process with lower clearance cannot access secret
> data, even if it is stored in database.

You also should be leveraging the OS in protecting SE-PostgreSQL from
interference by the client and ensuring that it is unbypassable for
accessing the database.  Are you just using the stock postgresql domain
in the refpolicy at present?  Any analysis of that domain and whether it
meets your needs adequately?  (side bar:  it seems to have a lot of
capabilities presently)

> In my understanding, Oracle pay no attention for the peer's clearance.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
