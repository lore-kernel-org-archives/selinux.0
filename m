Message-ID: <43BBF8C6.1070109@cornell.edu>
Date: Wed, 04 Jan 2006 11:33:10 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu>
In-Reply-To: <43BAB2D6.4030103@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Please use < 0 to check for error everywhere.
Another issue is that I'm rather confused by some of the current 
semanage code w' respect to local vs in-policy, so I'll try to explain 
again . All functions ending in _local (and the seusers one) act with 
respect to the local store. All functions not ending in _local act with 
respect to the final result (which includes local modifications stacked 
on top of policy). They do not act on policy alone.

Let's look at two cases of code that I don't understand:
This is from port.modify. The libsemanage meaning of modify includes 
adding things if they don't exist, but I understand this is not the case 
in the tool, so that explains all the exists checks...  However:

                (rc,exists) = semanage_port_exists_local(self.sh, k)
                if exists:
                        (rc,p) = semanage_port_query_local(self.sh, k)
                        (rc,exists) = semanage_port_exists(self.sh, k)
                        if exists:
                                (rc,p) = semanage_port_query(self.sh, k)
                        else:
                                raise ValueError("port %s/%s is not 
defined." % (proto,port))

                if rc != 0:
                        raise ValueError("Could not query port for 
%s/%s" % (proto, port))

This doesn't make sense, because of something exists locally, and your 
query succeeded, it will always exists in the final result, and the 
second query will return the exact same thing, so you already know the 
result to both of those function calls.

This is from the port add function:
                (rc,exists) = semanage_port_exists(self.sh, k)
                if exists:
                        raise ValueError("Port %s/%s already defined" % 
(proto, port))

                (rc,exists) = semanage_port_exists_local(self.sh, k)
                if exists:
                        raise ValueError("Port %s/%s already defined 
locally" % (proto, port))

Here, the second exception will never occur, because if the port exists 
locally, then it exists in-policy as well, and the first value error 
will be thrown.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
