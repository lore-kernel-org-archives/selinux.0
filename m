Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LK2BFX015093
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 15:02:11 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0LK06eS013281
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 20:00:07 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0LJrrR4023229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 13:53:53 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: run_init and interactive scripts
References: <87acr4u57h.fsf@glaurung.internal.golden-gryphon.com>
	<1106246926.26753.196.camel@moss-spartans.epoch.ncsc.mil>
	<87fz0ufwz0.fsf@glaurung.internal.golden-gryphon.com>
	<1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
Date: Fri, 21 Jan 2005 13:53:50 -0600
In-Reply-To: <1106333491.28551.159.camel@moss-spartans.epoch.ncsc.mil>
	(Stephen Smalley's message of "Fri, 21 Jan 2005 13:51:31 -0500")
Message-ID: <87brbiftip.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

On Fri, 21 Jan 2005 13:51:31 -0500, Stephen Smalley <sds@epoch.ncsc.mil> said: 

> On Fri, 2005-01-21 at 13:39, Manoj Srivastava wrote:
>> This is because I was putting the users terminal into raw mode, and
>> that also turns off output processing.  So, in the following patch
>> I introduce a function called tty_semi_raw, which is just like raw
>> mode, except we retain output processing. This is still fine for
>> things like aptitude and dselect, and makes the non-curses
>> applicationss look OK (like so)
>> ======================================================================
>> Shutting down mimedefang: [ OK ] Shutting down
>> mimedefang-multiplexor: [ OK ] ....
>> ======================================================================
>> 
>> This is an incremental patch in addition to the one I sent 12 hours
>> or so ago, which had the fflush stderr fixes. Please apply.

> Hmmm...I now get erratic behavior, sometimes only getting the first
> line of output (Stopping sshd: [ OK ]), sometimes getting the first
> line and the prefix of the second line, but still not the complete
> output.  And this behavior occurs under permissive mode as well, so
> it isn't related to any permissions.  Reverting this latest patch, I
> at least get consistent output, only losing the final OK status.

	That is strange, seeing that the only changes in that patch
 were _adding_ fflush statements.

	This is on a non-Se-Linux machine, I did this 5 times in a row
======================================================================
__> open_init_pty /etc/init.d/mimedefang restart
Shutting down mimedefang:                                   [  OK  ]
Shutting down mimedefang-multiplexor:                       [  OK  ]
Waiting for daemons to exit.......
Starting mimedefang-multiplexor:                            [  OK  ]
Starting mimedefang:                                        [  OK  ]
__> open_init_pty /etc/init.d/mimedefang restart
Shutting down mimedefang:                                   [  OK  ]
Shutting down mimedefang-multiplexor:                       [  OK  ]
Waiting for daemons to exit.....
Starting mimedefang-multiplexor:                            [  OK  ]
Starting mimedefang:                                        [  OK  ]
======================================================================

	I am attaching the full open_init_pty.c file below; I've
 tested this as extensively as I can on a number of Debian machines.

	manoj


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=open_init_pty.c
Content-Description: Full source of open_init_pty.c

/*                               -*- Mode: C -*- 
 * open_init_pty.c --- 
 * Author           : Manoj Srivastava ( srivasta@glaurung.internal.golden-gryphon.com ) 
 * Created On       : Fri Jan 14 10:48:28 2005
 * Created On Node  : glaurung.internal.golden-gryphon.com
 * Last Modified By : Manoj Srivastava
 * Last Modified On : Thu Jan 20 23:50:04 2005
 * Last Machine Used: glaurung.internal.golden-gryphon.com
 * Update Count     : 89
 * Status           : Unknown, Use with caution!
 * HISTORY          : 
 * Description      : 
 *
 * Distributed under the terms of the GNU General Public License v2
 *
 * open_init_pty
 *
 * SYNOPSIS:
 *
 * This program allows a systems administrator to execute daemons
 * which need to work in the initrc domain, and which need to have
 * pty's as system_u:system_r:initrc_t
 *
 * USAGE:
 *
 * * arch-tag: a5583d39-72b9-4cdf-ba1b-5678ea4cbe20
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>

#include <sysexits.h>

#include <pty.h>  /* for openpty and forkpty */
#include <utmp.h> /* for login_tty */
#include <termios.h>
#include <fcntl.h>

#include <sys/select.h>

static struct termios saved_termios;
static int            saved_fd = -1;
static enum { RESET, RAW, CBREAK } tty_state = RESET;

static int
tty_cbreak(int fd)
{
  struct termios buf;

  if(tty_state == RESET)
   {
     if(tcgetattr(fd, &saved_termios) < 0)
      {
        return -1;
      }
   }

  buf             = saved_termios;
  buf.c_lflag    &= ~(ECHO | ICANON); /* echo off, canonical mode off */
  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
  buf.c_cc[VTIME] = 0;
  if(tcsetattr(fd, TCSANOW, &buf) < 0)
   {
     return -1;
   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
  tty_state = CBREAK;
  saved_fd = fd;
  return 0;
}

static int
tty_raw(int fd)
{
  struct termios buf;

  if(tty_state == RESET)
   {
     if(tcgetattr(fd, &saved_termios) < 0)
      {
        return -1;
      }
   }

  buf             = saved_termios;
  /*
   * echo off, canonical mode off, extended input processing off,
   * signal chars off
   */
  buf.c_lflag    &= ~(ECHO | ICANON | IEXTEN | ISIG);
  /*
   * no SIGINT on break, CR-to-NL off, input parity check off, do not
   * strip 8th bit on input,output flow control off
   */
  buf.c_iflag    &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
  /* Clear size bits, parity checking off */
  buf.c_cflag    &= ~(CSIZE | PARENB);
  /* set 8 bits/char */
  buf.c_cflag    |= CS8;
  /* Output processing off */
  buf.c_oflag    &= ~(OPOST);

  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
  buf.c_cc[VTIME] = 0;
  if(tcsetattr(fd, TCSANOW, &buf) < 0)
   {
     return -1;
   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
  tty_state = RAW;
  saved_fd = fd;
  return 0;
}

static int
tty_semi_raw(int fd)
{
  struct termios buf;

  if(tty_state == RESET)
   {
     if(tcgetattr(fd, &saved_termios) < 0)
      {
        return -1;
      }
   }

  buf             = saved_termios;
  /*
   * echo off, canonical mode off, extended input processing off,
   * signal chars off
   */
  buf.c_lflag    &= ~(ECHO | ICANON | IEXTEN | ISIG);
  /*
   * no SIGINT on break, CR-to-NL off, input parity check off, do not
   * strip 8th bit on input,output flow control off
   */
  buf.c_iflag    &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
  /* Clear size bits, parity checking off */
  buf.c_cflag    &= ~(CSIZE | PARENB);
  /* set 8 bits/char */
  buf.c_cflag    |= CS8;
  /* Output processing off 
  buf.c_oflag    &= ~(OPOST); */

  buf.c_cc[VMIN]  = 1;             /* one byte at a time, no timer */
  buf.c_cc[VTIME] = 0;
  if(tcsetattr(fd, TCSANOW, &buf) < 0)
   {
     return -1;
   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
  tty_state = RAW;
  saved_fd = fd;
  return 0;
}

void
tty_atexit(void)
{
  if(tty_state != CBREAK && tty_state != RAW)
   {
     return;
   }

  if(tcsetattr(saved_fd, TCSANOW, &saved_termios) < 0)
   {
     return;
   } /* end of if(tcsetattr(fileno(stdin), TCSANOW, &buf) < 0) */
  tty_state = RESET;
  return;
}


int
main(int argc, char *argv[])
{
  pid_t child_pid;
  struct termios tty_attr;
  struct winsize window_size;
  int pty_master;
  int retval = 0;

  /* for select */
  fd_set readfds;
  fd_set writefds;
  fd_set exceptfds;


  int err_count = 0;

  /* for sigtimedwait() */
  struct timespec timeout;
  char buf[16384];

  sigset_t  signal_set;
  siginfo_t signalinfo;

  /* set up SIGCHLD */
  sigemptyset(&signal_set);      /* no signals */
  sigaddset(&signal_set, SIGCHLD); /* Add sig child  */
  sigprocmask(SIG_BLOCK, &signal_set, NULL); /* Block the signal */

  /* Set both to 0, so sigtimed wait just does a poll */
  timeout.tv_sec=0;
  timeout.tv_nsec=0;

  if(isatty(fileno(stdin)))
   {
     /* get terminal parameters associated with stdout */
     if(tcgetattr(fileno(stdout), &tty_attr) < 0)
      {
        perror("tcgetattr:");
        exit(EX_OSERR);
      } /* end of if(tcsetattr(&tty_attr)) */

     /* get window size */
     if( ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0 ) {
       perror("ioctl stdout:");
       exit(1);
     }

     child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
   } /* end of if(isatty(fileno(stdin))) */
  else
   {                            /* not interactive */
     child_pid = forkpty(&pty_master, NULL, NULL, NULL);
   }

  if(child_pid < 0)
   {
     perror("Fork:");
     fflush(stdout);
     fflush(stderr);
     exit(EX_OSERR);
   } /* end of if(child_pid < 0) */
  if(child_pid == 0)
   {
     /* in the child */
     struct termios s_tty_attr;
     if(tcgetattr(fileno(stdin), &s_tty_attr))
      {
        perror("Child:");
        fflush(stdout);
        fflush(stderr);
        exit(EXIT_FAILURE);
      }
     /* Turn off echo */
     s_tty_attr.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL);
     /* Also turn of NL to CR?LF on output */
     s_tty_attr.c_oflag &= ~(ONLCR);
     if(tcsetattr(fileno(stdin), TCSANOW, &s_tty_attr))
      {
        perror("Child:");
        exit(EXIT_FAILURE);
      }

     if ( execvp(argv[1], argv + 1) ) {
       perror("Exec:");
       fflush(stdout);
       fflush(stderr);
       exit(EXIT_FAILURE);
     }
   } /* end of if(child_pid == 0) */

  /* 
   * OK. Prepare to handle IO from the child. We need to transfer
   * everything from the child's stdout to ours.
   */

  FD_ZERO(&readfds);
  FD_ZERO(&writefds);
  FD_ZERO(&exceptfds);

  /*
   * Read current file descriptor flags, preparing to do non blocking reads
   */
  retval=fcntl(pty_master,F_GETFL);
  if(retval<0) {
    perror("fcntl_get");
    fflush(stdout);
    fflush(stderr);
    exit(EX_IOERR);
  }

  /* Set the connection to be non-blocking */
  if(fcntl(pty_master,F_SETFL, retval | O_NONBLOCK) < 0) {
    perror("fcnt_setFlag_nonblock:");
    fflush(stdout);
    fflush(stderr);
    exit(1);
  }

  FD_SET(pty_master, &readfds);
  FD_SET(pty_master, &writefds);
  FD_SET(fileno(stdin), &readfds);
  if(isatty(fileno(stdin)))
   {
     if(tty_semi_raw(fileno(stdin)) < 0)
      {
        perror("Error: settingraw mode:");
        fflush(stdout);
        fflush(stderr);
      } /* end of if(tty_raw(fileno(stdin)) < 0) */
     if(atexit(tty_atexit) < 0)
      {
        perror("Atexit setup:");
        fflush(stdout);
        fflush(stderr);
      } /* end of if(atexit(tty_atexit) < 0) */
   }

  /* while no signal, we loop around */
  while(1) {
    struct timeval interval;
    fd_set t_readfds;
    fd_set t_writefds;
    fd_set t_exceptfds;

    interval.tv_sec  = 0;
    interval.tv_usec = 100;

    t_readfds   = readfds;
    t_writefds  = writefds;
    t_exceptfds = exceptfds;

    /* check for the signal */
    retval = sigtimedwait(&signal_set, &signalinfo,&timeout);

    if( retval == SIGCHLD ) {
      /* child terminated */
      break;
    }
    else
     {
       if( retval < 0 ) {
         if(errno != EAGAIN) {
           perror("sigtimedwait");
           fflush(stdout);
           fflush(stderr);
           exit(EX_IOERR);
         }
         else
          {
            /* No signal in set was delivered within the timeout period specified */
          }
       }
     } /* end of else */

    if(select (pty_master + 1, &t_readfds, &t_writefds, &t_exceptfds, 
               &interval) < 0)
     {
       perror("Select:");
       fflush(stdout);
       fflush(stderr);
       exit (EX_IOERR);
     }

    if(FD_ISSET(pty_master, &t_readfds))
     {
       retval = read(pty_master, buf, (unsigned int)16384);
       if(retval < 0)
        {
          if(errno != EINTR && errno != EAGAIN) 
           {                    /* Nothing left to read?  */
             fflush(stdout);
             fflush(stderr);
             exit (EXIT_SUCCESS);
           } /* end of else */
        } /* end of if(retval < 0) */
       else
        {
          if(retval == 0)
           {
             if(++err_count > 5)
              {                 /* child closed connection */
                fflush(stdout);
                fflush(stderr);
                exit (EXIT_SUCCESS);
              }
           } /* end of if(retval == 0) */
          else
           {
             write(fileno(stdout), buf, (unsigned int)retval);
             fflush(stdout);
           } /* end of else */
        } /* end of else */
     }
    if(FD_ISSET(fileno(stdin), &t_readfds))
     {
       if(FD_ISSET(pty_master, &t_writefds))
        {
          retval = read(fileno(stdin), buf, (unsigned int)16384);
          if(retval < 0)
           {
             if(errno != EINTR && errno != EAGAIN)
              {                 /* Nothing left to read?  */
                fflush(stdout);
                fflush(stderr);
                exit (EXIT_SUCCESS);
              } /* end of else */
           } /* end of if(retval < 0) */
          else
           {
             if(retval == 0)
              {
                if(++err_count > 5)
                 {              /* lost controlling tty */
                   fflush(stdout);
                   fflush(stderr);
                   exit (EXIT_SUCCESS);
                 }
              } /* end of if(retval == 0) */
             else
              {
                write(pty_master, buf, (unsigned int)retval);
                fflush(stdout);
              } /* end of else */
           } /* end of else */
        } /* end of if(FD_ISSET(pty_master, &writefds)) */
     }    /* something to read on stdin */
  } /* Loop */

  fflush(stdout);
  fflush(stderr);

  exit(EXIT_SUCCESS);
} /* end of main() */

--=-=-=


-- 
It may be bad manners to talk with your mouth full, but it isn't too
good either if you speak when your head is empty.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
