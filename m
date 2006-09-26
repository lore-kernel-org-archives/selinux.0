Date: Tue, 26 Sep 2006 11:35:58 -0500
From: "George C. Wilson" <ltcgcw@us.ibm.com>
To: SELinux <SELinux@tycho.nsa.gov>, LSPP <redhat-lspp@redhat.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Irina Boverman <iboverma@redhat.com>,
        Serge Hallyn <serue@linux.ibm.com>, Trent Jaeger <tjaeger@cse.psu.edu>,
        Klaus Weidner <klaus@atsec.com>, Joe Nall <joe@nall.com>
Subject: Re: Labeled networking telecon
Message-ID: <20060926163558.GA28432@us.ibm.com>
References: <20060926004445.GA19051@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060926004445.GA19051@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Sep 25, 2006 at 07:44:45PM -0500, George C. Wilson wrote:
> Today the LSPP telecon participants suggested that we have a separate meeting
> to discuss labeled networking.  We would have to hold it soon because the RHEL5
> cutoff date is approaching.  IBM is willing to host using the same number as
> the LSPP call.
> 
> How about 1 PM CDT tomorrow, Tuesday, Sept. 26?  I think we need at least the
> core labeled networking experts from HP, IBM, NSA, Red Hat, Tresys, and TCS.
> Please respond to me if you are willing to participate.  Be sure to include
> issues you want to see on the agenda.  If 1 PM CDT tomorrow is bad for you,
> please send a counterproposal.  I will send out a notice at roughly 11 AM CDT
> if we can get what looks like a quorum.  If not, I will suggest a new time
> based on the responses.
> 

I have received only a limited number of responses.  None, however, suggested
we needed an alternate time.  I understand that notice is short and not everyone
agrees a call is useful.  Given the urgency Red Hat has expressed in meeting
their schedule, we will go ahead with the call.  I'll send the number to all the
respondents.  If you are on the LSPP call, please feel free to phone in even if
you haven't responded.  If you need the number, please let me know.  We will
post a summary of the discussion.

Agenda items so far: 

- Only a handful of people have the time and skills to build a system with the
  appropriate patches and provide feedback

- IPSec labeling end-to-end architecture

- Interaction of Netlabel and IPSec with Secmark

- Interaction with IPSec/Netlabel on same interface

- How to set a default label for a single machine (think Windows XP)

- How to set a default label for a network (IP/MASK)

- How to set a default label for a network interface

- getpeercon semantic consistency across the following
  - localhost IP sockets
  - Unix domain sockets
  - IPSec to remote machine with same security policy
  - Netlabel

- getpeercon meaning
  - personal preference is peer _socket_ context, that
    would be consistent with the CMWs that we use today

- Test schedule
  - When will Venkat's patch that allows getpeercon to work
    on local and IPSec IP sockets be in a kernel RPM?
  - When will a working context negotiating raccoon be in an RPM?

-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
