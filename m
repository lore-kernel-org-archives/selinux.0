Subject: Re: fork rules
From: Arpan Darivemula <apd005@latech.edu>
To: Valdis.Kletnieks@vt.edu
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200506060148.j561mRLu020682@turing-police.cc.vt.edu>
References: <1118002418.21085.10.camel@Raikiri.metadns.cx>
	 <200506060148.j561mRLu020682@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 12:59:13 -0500
Message-Id: <1118080753.10447.1.camel@Raikiri.metadns.cx>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for the reply.  It gave me a clearer understanding of the
process.
Arpan

On Sun, 2005-06-05 at 21:48 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 05 Jun 2005 15:13:38 CDT, Arpan Darivemula said:
> 
> > int main( int argc, char **argv )
> > {
> >         int pid;
> > 
> >         pid = getpid();
> >         printf( "Parent PID: %i\n", pid );
> > 
> >         if ( fork() == 0 )
> >         {
> >                 pid = getpid();
> >                 printf( "Child PID: %i\n", pid );
> >         }
> > }
> 
> I'd stick a 'sleep(120);' in there just before the fork() call, and then
> start using 'pa axZ' or similar to find out what you're actually running as.
> 
> > neverallow dsifork_exec_t self:process{fork};
> 
> You're probably not actually in dsifork_exec_t. Probably because:
> 
> > allow user_t dsifork_exec_t:file {execute execute_no_trans read};
> 
> Did you really want execute_*NO*_trans there?  That means that a user_t
> can exec a dsifork_exec_t and *remain* a user_t.  I think you wanted something
> like:
> 
> domain_auto_trans(user_t, dsi_fork_t, dsi_fork_exec_t);
> neverallow dsi_fork_t self:process(fork);
> 
> and then label the file as dsi_fork_exec_t, and apply the restriction to
> dsi_fork_t
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
