MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: variables for file context files
Date: Tue, 25 Sep 2007 22:00:02 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD49A292@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0236BF7C@blums0008.bluelnk.net> <1190322412.12553.56.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, September 20, 2007 2:07 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: variables for file context files
> 
> On Thu, 2007-09-20 at 10:03 -0700, Clarkson, Mike R (US SSA) wrote:
> > Is there a way to set variables in a file context file?
> >
> > For instance, I'd like to be able to do something like this in my
.fc
> > files
> >
> > ORACLE_HOME =
'/opt/nl/oracle/ora10gR2/app/oracle/product/10.2.0/db_1'
> > $ORACLE_HOME/lib/lib.+\.a -- gen_context(system_u:object_r:lib_t,s0)
> > $ORACLE_HOME/lib32/lib.+\.a --
gen_context(system_u:object_r:lib_t,s0)
> > ...
> >
> > That way if my ORACLE_HOME changes, I only have to change a single
line
> 
> The source .fc files are run through the m4 preprocessor like
everything
> else (that is how gen_context gets expanded).  So you can define a m4
> macro and use it in the source .fc file.  But the .fc file that gets
> packaged into a .pp file has already been preprocessed.

Being able to define a macro in the fc file great, but these appear to
have a scope local to the file in which they are defined. I find I often
have the same paths across multiple fc files, and it would be nice to be
able to have a single definition apply to all the files. Is there a way
to define them globally and put them in a central file?

Thanks

> 
> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
