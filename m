Message-ID: <41712EEF.9090402@redhat.com>
Date: Sat, 16 Oct 2004 10:23:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>,
   RH SELinux list <rhselinux-list@redhat.com>
Subject: mv and cp behavior.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Seems we have unexpected results when doing the mv command in both 
Strict and targeted policy.

A couple of examples where users are going to be confused (I was yesterday).

1. Setting up dhcp

     I was setting up a test dhcp server yesterday in targeted policy so
    I installed the machine,
    copied the dhcpd.conf file from an existing server to the /tmp
    directory.  Then I moved the file
    to the /etc/ directory.  I started the services and it blew up.  I
    ran audit2allow on the /var/log/messages
    file and got
    allow dhcpd_t tmp_t:file { read }
    At which point I went to the dhcp developer and asked him if dhcp
    had changed to require read access on /tmp.
    He said no, so I went back and looked at the log again and saw that
    it was trying to read dhcpd.conf as tmp_t.
    Now I understand what happened and ran restorecon on the file and
    everything worked fine.  The problem is
    that I have been using this stuff for a while and it confused me. 
    What is going to happen to our customers. 

2. Modifying files on a web server

    Collin has setup a web server and setup a directory underneath in
    /var/www/myblog it owned by httpd_staff_content_t which he
    can write files into and update his blog.  He edits files in his
    home directory can them moves them to the httpd directory.
    The problem is the apache server can't display them, because they
    have a context of staff_home_t.  (This would happen in both
    strict and targeted).    In this case he needs to use chcon to
    relabel the file to httpd_staff_content_t since restorecon would change
    the context to something else.

3.  Mv/cp do not follow the DAC conventions in all cases.  If I have a 
file marked as bin_t and executable and I move it to /tmp.
It is still executable in DAC but the bin_t context gets removed and 
replaced with some type of *_tmp_t context.

I believe that the what mv/cp is doing is wrong and we could do better, 
by default.

Seems we could do one or more of the following.

1.  Implement a matchpathcon in mv so the context is setup correctly on 
newly created files.  Users who can not do a matchpathcon
would fall back to current behavior.
    a.  This would fix the problem 1. dhcpd.conf would be marked 
dhcpd_conf_t
    b.  This would not work on problem 2. myblog.html would be marked 
httpd_sys_content_t
    c.  This would sometimes work for problem 3.  (IE if you move to a 
bin_t directory)
2.  When moving files to a new directory, adopt the context of the 
directories context rather them maintaining the current context.
    a.  This would not fix problem 1 (dhcpd.conf would be etc_t instead 
of dhcpd_etc_t)
    b.  This would work for problem 2. myblog.html would be 
httpd_staff_content_t
    c.  This would sometimes work for problem 3  (IE if you move to a 
bin_t directory)
3.  If the target file already exists mv -f would adopt the targets 
policy.  (cp already does this).
    a.  This would work on all three problems, but you still have the 
problem where the file does not exist.
4.  In certain situations file context is manipulated by policy.  IE if 
I move a file to /tmp, policy forces the file to be staff_tmp_t.

Suggestion on mv/cp behavior.  Combination of all above
1 If policy forces transition allow it to happen.  (IE if policy says 
staff users writing to /tmp must write staff_tmp_t than file ends up as 
staff_tmp_t)
2. If target file exists file after move has previous targets policy.
3. If target does not exist and mv can do a matchpathcon do it and set 
the context corretly.
4. If target does not exist and matchpathcon can not be done, adopt 
policy of target directory
5. If all above can't be done, use current behavior.

One problem with this is that other tools will act differently  IE 
rsync, ftp, scp ...

Ideas?

Dan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
