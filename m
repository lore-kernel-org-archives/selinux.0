Subject: Re: [ SEMANAGE ] Introduce record table
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, dwalsh@redhat.com,
   jbrindle@tresys.com
In-Reply-To: <43258D48.80702@cornell.edu>
References: <43256F48.7060909@cornell.edu>  <43258D48.80702@cornell.edu>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 15:43:22 -0400
Message-Id: <1126640602.29303.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 10:14 -0400, Ivan Gyurdiev wrote:
> The attached patch applies on top of the other one.
> It introduces the record table as the first thing
> which will be stored in the database config (a database config
> stores parameters specific to a database (a.k.a. file))
> 
> To clarify how this works - there's two sets of files here - one
> that works with generic record_t/record_key_t objects (treated as void*),
> and one that works with specific types that replace record_t/record_key_t.
> This essentially implements inheritance, which allows sharing of a lot of
> code (not yet merged). It's also a bit tricky to get it working, because we
> must keep track of where the specific types are defined.
> 
> The record table stores a set of functions which correspond
> to the record headers previously merged. It defines how certain
> operations are done for each particular type of record. In addition, it 
> provides
> some functions specific to the FILE backend. This table will
> be used by the file engine for polymorphism - it will work with
> the generic record types, but will be invoking the specific functions for
> each record based on what the table says.
> 
> Regarding database_init/close - those need to be integrated somewhere.. 
> likely
> on CONNECT/DISCONNECT...but I haven't done that yet..and it might change
> once semanage_handle_t appears.

(*key_free) prototype in src/record_file.h returns int, but the
implementations return void.  I assume void is correct.

Is there any concern about future namespace collision for the
dbase*/record* types, even though they are private to the library?  What
about when you start providing real implementations that have to bring
in external headers that may have conflicts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
