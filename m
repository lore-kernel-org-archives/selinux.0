Subject: fork rules
From: Arpan Darivemula <apd005@latech.edu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Sun, 05 Jun 2005 15:13:38 -0500
Message-Id: <1118002418.21085.10.camel@Raikiri.metadns.cx>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

Could I please get some help with the following rule:
Here is what I'm trying to do: I want to have a rule that toggles a
process fork.  Here is what I have

----fork.c----
# include <stdio.h>
# include <unistd.h>

int main( int argc, char **argv )
{
        int pid;

        pid = getpid();
        printf( "Parent PID: %i\n", pid );

        if ( fork() == 0 )
        {
                pid = getpid();
                printf( "Child PID: %i\n", pid );
        }
}
---------------
----fc file----
/home/dsi/fork  --      user_u:object_r:dsifork_exec_t
---------------
----te file----
type dsifork_exec_t, file_type, sysadmfile;
allow user_t dsifork_exec_t:file {execute execute_no_trans read};
neverallow dsifork_exec_t self:process{fork};
----------------
Now the process forks nonetheless. The rule does not make any difference
in stopping the fork. How can I control a fork in this ? I want to be
able to have a line that can allow or block the fork.


Thankyou
Arpan





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
