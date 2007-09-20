Subject: Re: variables for file context files
From: rob myers <rob.myers@gtri.gatech.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1190322412.12553.56.camel@moss-spartans.epoch.ncsc.mil>
References: <FB39F4E77226B448BC1388D3BE4E00CD0236BF7C@blums0008.bluelnk.net>
	 <1190322412.12553.56.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 20 Sep 2007 18:55:19 -0400
Message-Id: <1190328919.22264.98.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 17:06 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-20 at 10:03 -0700, Clarkson, Mike R (US SSA) wrote:
> > Is there a way to set variables in a file context file?
> > 
> > For instance, I'd like to be able to do something like this in my .fc
> > files
> > 
> > ORACLE_HOME = '/opt/nl/oracle/ora10gR2/app/oracle/product/10.2.0/db_1'
> > $ORACLE_HOME/lib/lib.+\.a -- gen_context(system_u:object_r:lib_t,s0)
> > $ORACLE_HOME/lib32/lib.+\.a -- gen_context(system_u:object_r:lib_t,s0)
> > ...
> > 
> > That way if my ORACLE_HOME changes, I only have to change a single line
> 
> The source .fc files are run through the m4 preprocessor like everything
> else (that is how gen_context gets expanded).  So you can define a m4
> macro and use it in the source .fc file.  But the .fc file that gets
> packaged into a .pp file has already been preprocessed.
> 

rather than define an m4 macro, i'm substituting for the default, if
necessary, at policy rpm build time.  an m4 macro might be a cleaner way
to go.

my code in progress is here:
http://www.stl.gtri.gatech.edu/rmyers/oracle-selinux/

if your oracle policy is in better shape than mine please send tips,
hints and patches. :)

rob.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
