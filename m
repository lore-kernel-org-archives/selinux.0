Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Russell Coker <russell@coker.com.au>
Subject: Re: Domain transition -- enabling user_r in eklogin
Date: Fri, 20 Dec 2002 10:25:34 -0600
Cc: SELinux@tycho.nsa.gov
References: <200212171725.MAA01304@moss-shockers.ncsc.mil> <200212190802.33560.pollard@admin.navo.hpc.mil> <200212192333.12008.russell@coker.com.au>
In-Reply-To: <200212192333.12008.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200212201025.34107.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 19 December 2002 04:33 pm, Russell Coker wrote:
> On Thu, 19 Dec 2002 15:02, Jesse Pollard wrote:
> > > It's the same thing.  If I can trick you into running some arbitary
> > > commands with your main role then I can get your ssh identity key and
> > > your gpg secret key.  These crypto keys are often worth more than the
> > > hardware that they are stored on...
> >
> > Only if access is permitted to be over an unsecured channel.
> >
> > The differentation between a local user and a remote user has to be
> > provided.
>
> The "if I can trick you" part means that the distinction between local and
> remote logins is probably not relevant.  Consider that you meet someone in
> Starbucks and say "there's this really cool program at www.foo.com" which
> they then download and run...
>
> Of course we could deny execute access to user_home_t but variations on the
> same theme can always be used while there are users who can be tricked and
> net access for easy back-channels.
>
> > Access to the secret key(s) probably should not be permitted from an
> > unsecured location/connection. This does require network labels to work.
>
> I guess you could have different roles, and have sshd only allow
> transitioning to a low security role which is prohibited from running ssh
> or gpg.  I wonder whether a domain that only has full access to
> user_home_dir_t and user_home_t can misdirect the actions of ssh or gpg..

Only if ssh/gpg doesn't have the ability to distinguish between secure data 
and insecure data. It would seem reasonable (for some level of reasonable)
that gpg should be able to sign less secure data using a normally inaccessable
secret key, IF it can recognize that changing/generating keys is not allowed
(or perhaps it should, provided the keys are also marked at the lower level - 
multilevel filesystems are a bitch to debug)

> I don't think that network labels allow us to do anything productive in
> this regard as network operations are so abstracted.  When a KDE ioslave
> can talk to a http proxy to get access to the outside network then making
> real use of network labels without seriously reducing functionality is
> almost impossible.
>
> For my aims a significant reduction in functionality is unacceptable.

I haven't analyzed how KDE is functioning yet, but full functionality would 
still exist IF the application is communicating to a remote host/network that
can be trusted at the same level as the local system. As soon as it is
communicating with a less trusted media/medium then it really should start
being restricted.

If it is at a lower level, then yes, some functionality should be lost - 
though that should not be significant, PROVIDED the X server and KDE know how
to compartmentalize the facilities communicating with that less trusted 
service.

Note- things like multi-media applications should not really have that much
of a problem. The lowest level label used would be the data source. If the
other channels (local audio, video, and control interface) can provide multi
level capable controls, then a controled low level channel should be possible
for the audio/video output. The user would see no loss of functionality.

I realize that this is NOT a simple thing to do. It does require full 
compartemented workstation support.

> > It does mean that the plugin for checking PGP signatures (at a minimum
> > the one for generating signatures) would have to be sufficiently separate
> > from the netscape process to be labeled separately. It could not use
> > loadable modules, for  instance. It also means any scripts started should
> > not have access either.
>
> The problem is that if you can run GPG currently you can encrypt the secret
> key to yourself with a password (IE not encrypting to a public key) and
> then decrypt the result to get the key.  A future version of GPG will
> address this.  I don't know how PGP performs in this regard.

Yup. That is one of the things the application must be able to evaluate. The
output media/medium is the determining factor here. To do this requires 
reading data with a high level label by a trusted process which must NOT
write that data to a media/medum with a low level label. That trusted process
SHOULD be able to read low labeled data, munch it using high labled data,
and write it to a low labeled media/medum since this is WHY it is a trusted 
process.

Granted some attacks do become possible. The low level data might be null, 
permitting a potential brute force attack with a known text. There are likely
other forms of attack too. Most of these can be remedied by adding in a random
string to prevent null text. It would become more usable and more transparent
to the user that way.

> > This is not a 100% solution - If netscape is used to download an
> > application, then the user proceeds to configure/compile/run then all
> > bets are off since the users actions are overriding the labels. It
> > should/could prevent a trojan from passing the files out though - it
> > would not be authorized access to the secret key(s) or the Kerberos
> > ticket cache. Only trusted utilities would have that capability.
>
> However if the ticket can't be used on other machines then the concern is
> not that it will be passed out, but that a process holding the ticked will
> be controlled by a program that is a proxy running on behalf of a program
> outside.

correct. That requires the program that is trusted to be able to evaluate the
security environment before taking action.

> One of my friends wrote a nifty set of CGI scripts to run a terminal
> session through a web page using standard web forms functionality.  It
> wouldn't be THAT much more difficult to do it the other way around and have
> machine running bash be the HTTP client and the HTTP server have the client
> side of the shell session.

Yup - have seen that one too. The usual remedy for this is that the trusted 
application evaluates it's security environment. The pty is assigned the 
level of the CGI. If the CGI is less trusted by the server it should be run
at a low security level. That terminal session could then attempt to run a
trusted process. however, if that trusted process attempts to write/obtain the
secret key, then it would/should refuse since it cannot operate higher than 
it's environment, as defined by the terminal session.

Personally, I dislike the idea of privileged applications. For a secure 
environment, I would prever all secret keys to be maintained by a security
server process, and all queries/updates for access to this data to be carried
out by that security server. This would turn at least half of GPG/Kerberos 
functions over to the security server (which should pass the actions on the
keys to sub processes. That includes encryption/decryption services, though
the security server may just pass a socket connection back to the requesting
application to allow that application to push data into the encryption engine
and either recieve the results, or the output could already be connected to
another socket for outgoing data.

Complicated perhaps, but no trusted application need exist other than the 
security server. And the users would have no need to access the secret keys
directly.

Currently, the kerberos server side does exactly this - the untrusted remote
must authenticate to the server, once trust is established, the server
interposes an encryption server between the terminal session and the remote
encryption client. If this were split up as above, then the kerberized telnet
operation becomes equivalent to the old telnet process except:

1. the telnet client requests a connection to the remote server by passing the
    request to the security server.
2. the security server takes the security level of the request from the
    process requesting it
3. the outgoing connection is established by the security server and labeled
   at the requesting level. The remote security server can then request
   authentication by whatever means accepted to both
4. Assuming acceptance, the security server puts an encryption service (if
   required) between the client and the outgoing socket.
5. The remote security server would put another encryption service between the
    incoming socket and the application server, running at the same level as
    the incoming socket label.

It would then be up to the application server whether to create a terminal
session or other processing server. The security server on both systems would
be controlling access to any secret keys needed.

Connection "acceptance" would be negotiated via (in this case) a kerberos 
authenction, any ticket forwarding handling, required encryption services,
and label matching - would all be handled by the security server. It would
even permit different algorithms to be selected. Might use AES to one system,
3DES to another, or RSA/Blowfish/... whatever was agreed upon by the two
systems.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
